Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2257A977F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjIURYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjIURYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:24:20 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC6A5FF9;
        Thu, 21 Sep 2023 10:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=0AQbnpGz46/mpizmCCyRAg/7hwEOBwjnI7rzkRejNrw=;
        t=1695316146; x=1696525746; b=G2QMVjnzufFtmb5P7z6Q3J/+ZBHqtVk0szWK9vtGuV0QGOG
        Rl2rp3sat3NFCzXUBLcGFGt33bdeHBFGA4bM9k+W4y2dNeMRzqjcEyZ+JG+y0YABFh+DboCzqNl82
        SSMff83SGx7kk711+kx9sw+/iTFRWuSmGmk9VPX06ga5nXFE8TxcW9DEzDcAlMtSrlRlCEFm8JJLB
        wILgcdynH9Vgm4bY6l9cYzwtCl79qf3FYGesV+dEl/Z0LmN5uoZS9jFf9xvqvYpSoCCT3j2Ovr6Zp
        1GWlEMXZDI/QQ0SP7ttzPlvuPSo/5FOG5G9PY5i+0MrtTqalVT6AexQGW4+hNc8Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qjLQQ-00DReL-34;
        Thu, 21 Sep 2023 17:17:07 +0200
Message-ID: <73ddab4151160d4d30aa83fb24ba6c976125da4a.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 1/4] tracing: add __print_sym() to replace
 __print_symbolic()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Thu, 21 Sep 2023 17:17:06 +0200
In-Reply-To: <20230921105129.cd040deee13e.I9bd2617499f0d170df58471bc51379742190f92d@changeid>
References: <20230921085129.261556-5-johannes@sipsolutions.net>
         <20230921105129.cd040deee13e.I9bd2617499f0d170df58471bc51379742190f92d@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-09-21 at 08:51 +0000, Johannes Berg wrote:
>=20
>  - Is it correct that we can assume RCU critical section when in
>    the lookup function? The SKB code currently does, but I may
>    not ever have actually run this code yet.

Well, I could easily answer that myself, and no, it's incorrect.

It'd be really useful though for these lookups to be able to do them
under RCU, so I think I'll fold this?

--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -34,7 +34,7 @@ struct trace_eval_map {
 struct trace_sym_def {
 	const char		*system;
 	const char		*symbol_id;
-	/* may return NULL */
+	/* may return NULL, called under rcu_read_lock() */
 	const char *		(*lookup)(unsigned long long);
 	/*
 	 * Must print the list: ', { val, "name"}, ...'
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -155,11 +155,13 @@ trace_print_sym_seq(struct trace_seq *p, unsigned
long long val,
 	const char *ret =3D trace_seq_buffer_ptr(p);
 	const char *name;
=20
+	rcu_read_lock();
 	name =3D lookup(val);
 	if (name)
 		trace_seq_puts(p, name);
 	else
 		trace_seq_printf(p, "0x%llx", val);
+	rcu_read_unlock();
=20
 	trace_seq_putc(p, 0);
=20


johannes

