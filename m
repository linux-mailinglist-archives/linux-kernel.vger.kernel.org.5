Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC27A775707
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 12:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjHIKZK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Aug 2023 06:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjHIKZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 06:25:08 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D0B1BFB;
        Wed,  9 Aug 2023 03:25:06 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 1CD4D8016;
        Wed,  9 Aug 2023 18:24:58 +0800 (CST)
Received: from EXMBX064.cuchost.com (172.16.6.64) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 9 Aug
 2023 18:24:58 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX064.cuchost.com
 (172.16.6.64) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 9 Aug
 2023 18:24:57 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Wed, 9 Aug 2023 18:24:57 +0800
From:   JeeHeng Sia <jeeheng.sia@starfivetech.com>
To:     Conor Dooley <conor@kernel.org>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Song Shuai <suagrfillet@gmail.com>,
        Petr Tesarik <petrtesarik@huaweicloud.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [RFT 1/2] RISC-V: handle missing "no-map" properties for
 OpenSBI's PMP protected regions
Thread-Topic: [RFT 1/2] RISC-V: handle missing "no-map" properties for
 OpenSBI's PMP protected regions
Thread-Index: AQHZxTKPVELaCqW/WUK93+UXGxBdOK/eAqwggAHhD4CAAed1gA==
Date:   Wed, 9 Aug 2023 10:24:57 +0000
Message-ID: <3931cc7932e644bd88f9baf2beddd00d@EXMBX066.cuchost.com>
References: <20230802-purse-hydrant-6f44f77364b0@wendy>
 <20230802-detention-second-82ab2b53e07a@wendy>
 <3e066032031e4552b4b7903755deb669@EXMBX066.cuchost.com>
 <20230808-humility-rut-e1e46cf75708@spud>
In-Reply-To: <20230808-humility-rut-e1e46cf75708@spud>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [210.186.215.22]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Tuesday, August 8, 2023 9:13 PM
> To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> Cc: Conor Dooley <conor.dooley@microchip.com>; palmer@dabbelt.com; Paul Walmsley <paul.walmsley@sifive.com>; Atish Patra
> <atishp@rivosinc.com>; Anup Patel <apatel@ventanamicro.com>; Alexandre Ghiti <alexghiti@rivosinc.com>; Björn Töpel
> <bjorn@rivosinc.com>; Song Shuai <suagrfillet@gmail.com>; Petr Tesarik <petrtesarik@huaweicloud.com>; linux-
> riscv@lists.infradead.org; linux-kernel@vger.kernel.org; stable@vger.kernel.org
> Subject: Re: [RFT 1/2] RISC-V: handle missing "no-map" properties for OpenSBI's PMP protected regions
> 
> On Mon, Aug 07, 2023 at 12:44:07AM +0000, JeeHeng Sia wrote:
> 
> > > +/* SBI implementation IDs */
> > > +#define SBI_IMP_OPENSBI	1
> > I would suggest to create an enum struct for the SBI Imp ID in
> > the sbi.h file. What do you think?
> 
> I'm not really sure what the advantage of doing so is.
The macro SBI_IMP_OPENSBI seems weird (I would read it as "SBI Implementation OpenSBI"). However, if we implement an enum struct for SBI_IMP_ID (There are numerous IDs available), the macro can be abbreviated to OpenSBI. By doing this, the conditional checking of the implementation ID would be more readable, as shown below:
if (sbi_firmware_id != OPENSBI)
