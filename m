Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BA480E71B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346332AbjLLJLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235141AbjLLJKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:10:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6039CD9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:10:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54090C433C8;
        Tue, 12 Dec 2023 09:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702372253;
        bh=G/e1xpm/hKZ3MJDkHyeCRQZimxBoNiwGH3pKX4ZM1l4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=myE58hcwneBqlyVp/egwnurAOc9Clyi2m0qALmtMNnq8zzcv07S2f9ihk/MnTsKep
         VB6akC5LYtaXHfrdDBqJMeqneEeJ6055MY/x3sD7Khq2nYqKqxlrCuIbhOKUEE/9VB
         QgPTKHBImkTpUq+MqzlrLddgCHfRsZKJ+Q2GkII81Dw6Xoh/IosssZNZy5BKlB53/q
         2VF5o1KvZVWbEMtG+Y+JrrGgPy3aITdGBt5gEe3sYGYeOYFp5oPmbxG/06O864z+0s
         njkry0BA5XVwm79TPpo0JBxBRj+k1hMqyrDRx9rDt2PXjG5HwVca2mRGOxBHK8JemW
         /0KPuALAhIu6g==
Date:   Tue, 12 Dec 2023 09:10:48 +0000
From:   Will Deacon <will@kernel.org>
To:     Fuad Tabba <tabba@google.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/13] arm64/sysreg: Update ID_AA64ISAR2_EL1 defintion
 for DDI0601 2023-09
Message-ID: <20231212091047.GA28147@willie-the-truck>
References: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org>
 <20231209-b4-arm64-sysreg-additions-v1-6-45284e538474@kernel.org>
 <CA+EHjTzdKS+ardXUofO+U1vnsOC3QjiJUBuKCHWw6z6zKdVGSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+EHjTzdKS+ardXUofO+U1vnsOC3QjiJUBuKCHWw6z6zKdVGSA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 09:07:25AM +0000, Fuad Tabba wrote:
> On Sat, Dec 9, 2023 at 1:03 AM Mark Brown <broonie@kernel.org> wrote:
> >
> > DDI0601 2023-09 defines some new fields in previously RES0 space in
> > ID_AA64ISAR2_EL1, together with one new enum value. Update the system
> > register definition to reflect this.
> >
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> 
> > ---
> >  arch/arm64/tools/sysreg | 24 ++++++++++++++++++++++--
> >  1 file changed, 22 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> > index c48a3b8d00ad..3f382f8d0f4a 100644
> > --- a/arch/arm64/tools/sysreg
> > +++ b/arch/arm64/tools/sysreg
> > @@ -1365,7 +1365,14 @@ EndEnum
> >  EndSysreg
> >
> >  Sysreg ID_AA64ISAR2_EL1        3       0       0       6       2
> > -Res0   63:56
> > +UnsignedEnum   63:60   ATS1A
> > +       0b0000  NI
> > +       0b0001  IMP
> > +EndEnum
> > +UnsignedEnum   59:56   LUT
> > +       0b0000  NI
> > +       0b0001  IMP
> > +EndEnum
> >  UnsignedEnum   55:52   CSSC
> >         0b0000  NI
> >         0b0001  IMP
> > @@ -1374,7 +1381,19 @@ UnsignedEnum     51:48   RPRFM
> >         0b0000  NI
> >         0b0001  IMP
> >  EndEnum
> > -Res0   47:32
> > +Res0   47:44
> > +UnsignedEnum   43:40   PRFMSLC
> > +       0b0000  NI
> > +       0b0001  IMP
> > +EndEnum
> > +UnsignedEnum   39:36   SYSINSTR_128
> > +       0b0000  NI
> > +       0b0001  IMP
> > +EndEnum
> > +UnsignedEnum   35:32   SYSREG_128
> > +       0b0000  NI
> > +       0b0001  IMP
> > +EndEnum
> >  UnsignedEnum   31:28   CLRBHB
> >         0b0000  NI
> >         0b0001  IMP
> > @@ -1398,6 +1417,7 @@ UnsignedEnum      15:12   APA3
> >         0b0011  PAuth2
> >         0b0100  FPAC
> >         0b0101  FPACCOMBINE
> > +       0b0110  PAUTH_LR
> 
> Nit: PAuth and PAuth2 only have the PA as uppercase in this file,
> which matches the spec. Should PAuth_LR be the same?

I renamed it to PAuth_LR following your comment, but it looks like
ID_AA64ISAR1_EL1 is still missing this field entirely for the API and
APA fields.

Will
