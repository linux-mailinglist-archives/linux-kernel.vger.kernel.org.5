Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02C07E9C51
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 13:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjKMMoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 07:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjKMMoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 07:44:00 -0500
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09762D4C;
        Mon, 13 Nov 2023 04:43:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1699879429; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=TpLi3oQ8GoTB+6ihVITYHXacVoLaOjMW0twqtUM9wcpQwvnjBXTgpog999BLmTt2NBjjinnTbDrd8PzE/WFwOvRtmATsjxI8cMVvQakAvlD7SrAh2JyRTgDr5ZP3X1wmwKT+wW2hCHdBmX5SyNPH/4VdVeuutONSNI1m6SX1yls=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1699879429; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=4k2Xe+Ff7V1rPH9Jsj0WdhLJ24+KPwWeKLtocVI3BUk=; 
        b=HdVvKYiM4BE6VcLBqULl4Rk2Yu81yOrtYHgjaBSV61StYigCbKXGP9sapxQGk9nFB844QTPH+C+zn4AbdK5ktAoqVUxp0EsMDkTdE15VSsC9eM9eyb2WHFzQZai/gbU8HTIprofduKFV++eGRcz/3sXyce1v7DUe2fOJaysU+Iw=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1699879429;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Message-ID:Date:Date:MIME-Version:To:To:Cc:Cc:References:Subject:Subject:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=4k2Xe+Ff7V1rPH9Jsj0WdhLJ24+KPwWeKLtocVI3BUk=;
        b=rswSdAN6gnFrMzOQt9vXNL/VRGbo5Jhve86IrtwUErDPoxAxkHFzEFDvAsDMFHYj
        SnpMmFVV414LvtBdxBGY4FIcJL3ThW0fZ46L5bD82i/4JwIPvn+Sr4I2v05fdFmZmzJ
        TRamIyHO3bN4E5dzSDhBDYsKxprw6APhssXo6ZIE=
Received: from [192.168.1.11] (106.201.112.144 [106.201.112.144]) by mx.zoho.in
        with SMTPS id 169987942777756.48529072906388; Mon, 13 Nov 2023 18:13:47 +0530 (IST)
Message-ID: <7d56a505-3093-4863-a7b1-9454ec6447ae@siddh.me>
Date:   Mon, 13 Nov 2023 18:13:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To:     syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000cb112e0609b419d3@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in
 nfc_alloc_send_skb
Content-Language: en-US, en-GB, hi-IN
From:   Siddh Raman Pant <code@siddh.me>
In-Reply-To: <000000000000cb112e0609b419d3@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 645677f84dba..ea0e6c85866d 100644
--- a/net/nfc/llcp_sock.c                                                                 
+++ b/net/nfc/llcp_sock.c
@@ -796,6 +796,11 @@ static int llcp_sock_sendmsg(struct socket *sock, struct msghdr *msg,
        }                               
                                                 
        if (sk->sk_type == SOCK_DGRAM) { 
+               if (sk->sk_state != LLCP_BOUND) {
+                       release_sock(sk);
+                       return -ENOLINK;
+               }                                                 
+                                               
                DECLARE_SOCKADDR(struct sockaddr_nfc_llcp *, addr,
                                 msg->msg_name);
 
