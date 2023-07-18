Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FDF757FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjGROn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbjGROn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:43:26 -0400
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FFC171A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
        ; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
        :Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=rZDLcsetw14NvgAmWpqUlwaLyO2tN1KOZr18htadwm4=; b=UrkixZwAqt5H0KL5t+vYEoaE9p
        Xcrcn6NXnEd6yx88zlve3roQToHlEIEz/waU19HU+IER9emsRt6yvDsinaoD9Av24JeR9zIuK+Z6g
        kLdtZGyfAqnqog6FDpKArG0yws7XN5rlRmlzuvnYQuYwWhxKdwtZ9wUsKrlYmKQhyE+h8dm88IRbs
        uW6yv2OxT6rA9xAbwHXjCRgC4O7XZTXAFChb92ATsemvpkxb4pdT1qj4ukxZ0xcG7z3iIq5+DptQJ
        YfyB+o5ARTxe/CBPBT8YqyLVbdFrnHKrw4Y6u2j/x61QbcMO/06iNkpySxgq0UPPfFkaTkB0CKsBD
        trrwsK6w==;
Received: from [192.168.1.4] (port=58146 helo=SH-EX2013.helmholz.local)
        by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.96)
        (envelope-from <Ante.Knezic@helmholz.de>)
        id 1qLlv1-0004IH-1N;
        Tue, 18 Jul 2023 16:43:15 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Tue, 18 Jul 2023 16:43:14 +0200
From:   Ante Knezic <ante.knezic@helmholz.de>
To:     <pabeni@redhat.com>
CC:     <andrew@lunn.ch>, <ante.knezic@helmholz.de>, <davem@davemloft.net>,
        <edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <olteanv@gmail.com>
Subject: Re: [PATCH net-next v2] net: dsa: mv88e6xxx: Add erratum 3.14 for 88E6390X and 88E6190X
Date:   Tue, 18 Jul 2023 16:43:10 +0200
Message-ID: <20230718144310.4887-1-ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <164e816460523a9b54b06b1586f89b3bd2d09fc9.camel@redhat.com>
References: <164e816460523a9b54b06b1586f89b3bd2d09fc9.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> It does not apply cleanly to net-next. Please respin. You can retain
> Andrew's Reviewed-by tag.

Respin might need a complete rework of the patch as with the
conversion of 88e639x to phylink_pcs (introduced with commit
e5b732a275f5fae0f1342fb8cf76de654cd51e50) the original code flow
has completely changed so it will not be as simple as finding a new
place to stick the patch. 
The new phylink mostly hides away mv88e6xxx_chip struct which is needed 
to identify the correct device and writing to relevant registers has also
changed in favor of mv88e639x_pcs struct etc.
I think you can see where I am going with this. In this sense I am not sure 
about keeping the Reviewed-by tag, more likely a complete rewrite 
should be done.
I will repost V3 once I figure out how to make it work with the new
framework.

