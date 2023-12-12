Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A732880E38D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 06:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjLLFCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 00:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjLLFCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 00:02:11 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86980BF;
        Mon, 11 Dec 2023 21:02:17 -0800 (PST)
Received: from [192.168.68.112] (ppp118-210-187-191.adl-adc-lon-bras34.tpg.internode.on.net [118.210.187.191])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 2CE0A20174;
        Tue, 12 Dec 2023 13:02:10 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1702357334;
        bh=0JEzWpk4MDY+4Qk2dR6y4bAMD86j0zFUEcjMhDT332Q=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=lgoJA7PmVBvR5AKglnaYAriJaabfIuzhglD3ToN4ObIUrKizYa2IYtQIVYhl7kuwH
         RdjqjlDjLTr4+glfyW/g1DbmQY8HjjE7tSq92XW0ieGsYz618SZHefj3jwd14qq7Tw
         adtG4cvXeJKo6rdiBv1O1xq6JiM8VKkSJRFxtq7nkUk/bx7ej/dV1gFnyl9zqzTEKL
         NMOihBAHpihBg/+7Umfre73a4+lkiHnP3uVw1A+bshV37EuhapBZpTQw17npLf3dS+
         /7wsS02MyVjpQAZWH+i104dTJp3hDl4JzsuP/xhBlUM9QH5qAsZdXKq3QE655ymHBx
         E4CIH3aX7Aw1g==
Message-ID: <c11d2365e67299dcc5ff7319a1856dbaa985d61e.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4 0/2] i2c: aspeed: Late ack Tx done irqs and handle
 coalesced start with stop conditions
From:   Andrew Jeffery <andrew@codeconstruct.com.au>
To:     Joel Stanley <joel@jms.id.au>,
        Quan Nguyen <quan@os.amperecomputing.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Cosmo Chou <chou.cosmo@gmail.com>,
        Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>
Date:   Tue, 12 Dec 2023 15:32:09 +1030
In-Reply-To: <CACPK8Xc6-M9fsx3AUPobzvG6sjCrr8Sj5B3Q4Onp5wGvMm_BrA@mail.gmail.com>
References: <20231211102217.2436294-1-quan@os.amperecomputing.com>
         <CACPK8Xc6-M9fsx3AUPobzvG6sjCrr8Sj5B3Q4Onp5wGvMm_BrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-12-12 at 13:09 +1030, Joel Stanley wrote:
> On Mon, 11 Dec 2023 at 20:52, Quan Nguyen <quan@os.amperecomputing.com> w=
rote:
> >=20
> > This series consists of two patches to handle the below issues observed
> > when testing with slave mode:
> >   + The coalesced stop condition with the start conditions
> >   + Early ack'ed of Tx done (ACK and NAK) causing "Unexpected Ack on
> >   read request".
>=20
> Looks good. I've reached out to a few people who use slave mode to ask
> for review and testing on hardware. As long as they don't come back
> with issues, we should get this merged and backported to stable.
>=20
> Reviewed-by: Joel Stanley <joel@jms.id.au>

I've dropped a build with the patches onto an AST2600 EVB and lightly
exercised the affected paths using NVMe-MI over MCTP to a Micron 7450.

Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Andrew

