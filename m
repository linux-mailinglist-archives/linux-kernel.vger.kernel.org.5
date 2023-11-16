Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9072A7EE598
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 17:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345189AbjKPQ4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 11:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjKPQ4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 11:56:33 -0500
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E260B7;
        Thu, 16 Nov 2023 08:56:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1700153758; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=EBFhDQIZ/ojh3iwmVoYLmu7j2lhkfgvGQv9g8VbQOyDP8pjX3ABO3FIHvg6AU30KenHhm408h83yuPNpred96gJF6b1/h7SD/V5IxR13eqQ8WJPhuRiLoM/e05HKFWFXRn9GCUt/e4eRHayqlEQrjnHTZ6WW+fWCzqG+Obhf2fc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1700153758; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=jF/VM6Ul6I5Q3qO6v36yzMs2LjPy0A7+pMrSCdzjPQY=; 
        b=AB3UXrOjOulybkeopPnvgv3loT6r3KVqRSVaR3zKKzn81GlY47m9WfREfwcSrexzlR7GUgkFRTBAdrJg7H0CP1a+jeXK+UmOIbbMgbk5LMHteH7u6anTb7tH8b7n9nHs4tp2mZzpvTO1pue+JbB2d823l3fI4367i9o+hesqcXQ=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1700153758;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Message-ID:Date:Date:MIME-Version:To:To:Cc:Cc:References:Subject:Subject:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=jF/VM6Ul6I5Q3qO6v36yzMs2LjPy0A7+pMrSCdzjPQY=;
        b=nLGtAtR+WeGYnQeiqkfbAOojEyOxm/e/JnJYKgiTDy41u2VEIe7A5mof6QZAYnJz
        oewTIoT+OPoeJiJx5MaoXMP79eOh8nautjXS+TIt0Coir96wAIgiZd2EbzBJK/vAKDI
        x0NADcOS1IAzj1yyI4/m/c55+PKlTyN73/Rc3mxA=
Received: from [192.168.1.11] (106.201.112.144 [106.201.112.144]) by mx.zoho.in
        with SMTPS id 170015375587354.15308217634913; Thu, 16 Nov 2023 22:25:55 +0530 (IST)
Message-ID: <7824cf85-178f-4fca-8058-b9a1f49d3113@siddh.me>
Date:   Thu, 16 Nov 2023 22:25:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To:     davem@davemloft.net, edumazet@google.com,
        krzysztof.kozlowski@linaro.org, kuba@kernel.org, pabeni@redhat.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TLDR: Different stages of 1 and 2 can race with each other causing UAF.

1. llcp_sock_sendmsg -> nfc_llcp_send_ui_frame -> loop call (nfc_alloc_send_skb(nfc_dev))

2. virtual_ncidev_close -> [... -> nfc_llcp_socket_release -> ...] -> [... -> nfc_free_device]

---

Hi,

I've been trying to fix this bug for some time but ending up getting
stuck every now and then. If someone could give more inputs or fix it,
it will be really helpful.

This bug is due to racing between sendmsg and freeing of nfc_dev.

For connectionless transmission, llcp_sock_sendmsg() codepath will
eventually call nfc_alloc_send_skb() which takes in an nfc_dev as
an argument for calculating the total size for skb allocation.

virtual_ncidev_close() codepath eventually releases socket by calling
nfc_llcp_socket_release() (which sets the sk->sk_state to LLCP_CLOSED)
and afterwards the nfc_dev will be eventually freed.

When an ndev gets freed, llcp_sock_sendmsg() will result in an
use-after-free as it

(1) doesn't have any checks in place for avoiding the datagram sending.
	(1.1) Checking for LLCP_CLOSED in llcp_sock_sendmsg() does make
	      the racing less likely. For -smp 6 it did not trigger on
	      my PC, leading me to naively think that was the solution
	      until syzbot told me quite some time later that it isn't.

(2) calls nfc_llcp_send_ui_frame(), which also has a do-while loop which
    can race with freeing (a msg with size of 4096 is sent in chunks of
    128 in this repro).
	(2.1) By this I mean just moving the nfc_dev access from
	      nfc_alloc_send_skb to inside this function, be it
	      inside or outside the loop, naturally doesn't work.

When an nfc_dev is freed and we happened to get headroom and tailroom,
PDU skb seems to be not allocated and ENXIO is returned.

I tried to look at other code in net subsystem to get an idea how other
places handle it, but accessing device later in the codepath does not
seem to not be a norm. So I am starting to think some refactoring of the
locking logic may be needed (or maybe RCU protect headroom and tailroom?).

I don't know if I'm correct, but anyways where does one start?

Thanks,
Siddh
