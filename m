Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395D3801D3B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 15:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjLBOMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 09:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBOMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 09:12:14 -0500
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B1311C;
        Sat,  2 Dec 2023 06:12:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1701526329; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=co8hkZZFiaUijqDwUXVAnba0UTOchAS1ZCo1E+u0JgS2NN0kdLyzd0h0iSc4AY+4kxxbcOJFI86/H0iROftCuPNsqI8Wn3IiCXNKHdRoTXfretuIgTjKTENmkyw3a6TnBl8cVXZml1nLDRFHAqIChOIxLNciU3kgWVtVC1EWIyE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1701526329; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=vsqkAH0yBJeH0U/+V5ZEHt7TaF6k3M78Pb7xpgVsqEc=; 
        b=VJ9Uzjbb4koo2V8N9b9yOQtP57Bs0zG6k3H7AIIaygavMNFyvgxKdnOxysQGFErweacLN/b3ah6jM1qnJZWOOWsZPNcbAj2b1ZgojOaidI8vyhhh8cE6L3Hvwd8my0U7xtSshIa0W43xAcmtXi3Diyaypk0LDdYt7VOOxvH4s+k=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1701526329;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Message-ID:Date:Date:MIME-Version:To:To:Cc:Cc:References:Subject:Subject:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=vsqkAH0yBJeH0U/+V5ZEHt7TaF6k3M78Pb7xpgVsqEc=;
        b=OPV+rVKzM7GRhVfBhdlrYFcwYl8rayZlm4KH6tMnKhz/v0NnOJusN9kbEKdJ5RKp
        CYhjQ5DlR7eSEJr2VGGsL5fpxOiw6Ic6WeKX8f66Ti02XdY31/+i50gURIehCnfU9Iy
        ZiWcazx/ADlmp0/rDDQ2x6jIC9UO0/wuLXzx0pdk=
Received: from [192.168.1.12] (122.170.35.155 [122.170.35.155]) by mx.zoho.in
        with SMTPS id 1701526327621523.3303507041147; Sat, 2 Dec 2023 19:42:07 +0530 (IST)
Message-ID: <b4bc6554-6870-43fe-87df-1a2f947e6408@siddh.me>
Date:   Sat, 2 Dec 2023 19:42:05 +0530
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test repro on main.

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
