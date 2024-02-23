Return-Path: <linux-kernel+bounces-78461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC868613C9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5598D284E6A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0265283A03;
	Fri, 23 Feb 2024 14:17:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A6781ACA
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708697829; cv=none; b=LTThyjxGmJlH3zv3ETEALeeVDGhd36XPtVk9PDHSSq79GckRQkN+mpZPsF3GCmvlmXqW2UogN16o7qyHHOqyEqsdFSv+54uyRyA4GJdGRueF+aqMJSF3G2lMOfiTP8woYW15TXEre8cPebOMTZrV6WRTg0HwZsT5Wza1Aw8qaig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708697829; c=relaxed/simple;
	bh=3xrOW9URhoOAn6cXs/5dE696kcxcVdjb+ohYIPRoMYs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=VDNtnAgtwBEs3xlawjKTx7cQ3miDTG8I3cQ5eC8EHpKydnfyBsbLNb++QRz8TL6yaZXVTZxF9O8BHzqaksW4fkbQLW6P60yo0Yw2Mx9+y1A1k3yJ8MNo1S6jpj9Ni1Orron/4FOTRrZ6Tc+oc6ibbYE9kZZSUzLdoqsJhasxB7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D546C4166B;
	Fri, 23 Feb 2024 14:17:09 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rdWOE-000000077Ng-2Ezo;
	Fri, 23 Feb 2024 09:19:02 -0500
Message-ID: <20240223141902.394601874@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 23 Feb 2024 09:18:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jeff Layton <jlayton@kernel.org>,
 Neil Brown <neilb@suse.de>,
 Olga Kornievskaia <kolga@netapp.com>,
 Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>,
 Chuck Lever <chuck.lever@oracle.com>
Subject: [for-next][PATCH 06/13] NFSD: Fix nfsd_clid_class use of __string_len() macro
References: <20240223141838.985298316@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

I'm working on restructuring the __string* macros so that it doesn't need
to recalculate the string twice. That is, it will save it off when
processing __string() and the __assign_str() will not need to do the work
again as it currently does.

Currently __string_len(item, src, len) doesn't actually use "src", but my
changes will require src to be correct as that is where the __assign_str()
will get its value from.

The event class nfsd_clid_class has:

  __string_len(name, name, clp->cl_name.len)

But the second "name" does not exist and causes my changes to fail to
build. That second parameter should be: clp->cl_name.data.

Link: https://lore.kernel.org/linux-trace-kernel/20240222122828.3d8d213c@gandalf.local.home

Cc: Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>
Cc: Olga Kornievskaia <kolga@netapp.com>
Cc: Dai Ngo <Dai.Ngo@oracle.com>
Cc: Tom Talpey <tom@talpey.com>
Fixes: d27b74a8675ca ("NFSD: Use new __string_len C macros for nfsd_clid_class")
Acked-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/nfsd/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index d1e8cf079b0f..2cd57033791f 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -843,7 +843,7 @@ DECLARE_EVENT_CLASS(nfsd_clid_class,
 		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
 		__field(unsigned long, flavor)
 		__array(unsigned char, verifier, NFS4_VERIFIER_SIZE)
-		__string_len(name, name, clp->cl_name.len)
+		__string_len(name, clp->cl_name.data, clp->cl_name.len)
 	),
 	TP_fast_assign(
 		__entry->cl_boot = clp->cl_clientid.cl_boot;
-- 
2.43.0



