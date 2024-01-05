Return-Path: <linux-kernel+bounces-17968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7451D82561E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90F051C2285E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2472E3FD;
	Fri,  5 Jan 2024 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="EFlKDgrG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E452D78C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 14:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-117.bstnma.fios.verizon.net [173.48.102.117])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 405EniVh013879
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Jan 2024 09:49:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1704466190; bh=96QxMD2/uzSjfYXlD+HiWCgYGOHYLzMvGcx5dmU4D5Q=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=EFlKDgrGJ6Vw6By+GICPZ//aLgNbSy8l+v2ymqqwG7UcVHMsFKkeSDG+gB6334Rxl
	 Q88V4YxJ2hQZ32POiWYzRYQtYJZ4mknnlgEE3fSOl3UL81S8HuQTL8Hs5AdlhUoLRA
	 g3MelcFWO2lh7Bj+gTzHmEkdQ3fsuF0cTfgrqAxPstLXIrSFNwiib2Oc8b6DtwncUn
	 /2CAF726LZHGkfiZTZm17nimUyBdKfnIRSE6gwBbZabp5AUaG9K+wsDcLN79xS9CKW
	 HHpvKwZl1/O24IgQOQVviPb/KrgPjJ/Bnv5WfA8dUUFBk2sEy3XKiS3i8abQl0BD56
	 eKAXm1Gfw+RKw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 91F3415C0276; Fri,  5 Jan 2024 09:49:44 -0500 (EST)
Date: Fri, 5 Jan 2024 09:49:44 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jingzi Meng <mengjingzi@iie.ac.cn>
Cc: gregkh@linuxfoundation.org, gpiccoli@igalia.com, john.ogness@linutronix.de,
        keescook@chromium.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com, rostedt@goodmis.org,
        senozhatsky@chromium.org, tony.luck@intel.com
Subject: Re: [PATCH] cap_syslog: remove CAP_SYS_ADMIN when dmesg_restrict
Message-ID: <20240105144944.GA246367@mit.edu>
References: <2024010306-tweezers-skinhead-083e@gregkh>
 <20240105062007.26965-1-mengjingzi@iie.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240105062007.26965-1-mengjingzi@iie.ac.cn>

On Fri, Jan 05, 2024 at 02:20:07PM +0800, Jingzi Meng wrote:
> CAP_SYSLOG was separated from CAP_SYS_ADMIN and introduced in Linux
> 2.6.37 (2010-11). For a long time, certain syslog actions required
> CAP_SYS_ADMIN or CAP_SYSLOG. Maybe it’s time to officially remove
> CAP_SYS_ADMIN for more fine-grained control.
> 
> CAP_SYS_ADMIN was once removed but added back for backwards
> compatibility reasons. In commit 38ef4c2e437d ("syslog: check cap_syslog
> when dmesg_restrict") (2010-12), CAP_SYS_ADMIN was no longer needed. And
> in commit ee24aebffb75 ("cap_syslog: accept CAP_SYS_ADMIN for now")
> (2011-02), it was accepted again. Since then, CAP_SYS_ADMIN has been
> preserved.
> 
> Now that almost 13 years have passed, the legacy application may have
> had enough time to be updated.

What testing have you done to make sure that this is OK?  "May have
had enough time"?  That's not very reassuring?

Also, note that we can't actually reuse the bit position of
CAP_SYS_ADMIN since it's likely that there may be pre-existing
capability masks that are still using that position.  So there isn't
all that much upside in trying to retire CAP_SYS_ADMIN --- if you as a
system administrator think it's not too course, then just don't use
it.

It's unclear to me what goal you have in trying to mess with the
capability definitions?  Perhaps it might be useful if you were to
explicitly state your goals in these proposals?

Thanks,

						- Ted

