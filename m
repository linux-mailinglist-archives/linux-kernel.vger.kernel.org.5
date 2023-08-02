Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651F676CD4D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbjHBMpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbjHBMpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:45:05 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBFC30F1
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 05:44:36 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7AC5C20004;
        Wed,  2 Aug 2023 12:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690980270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8dOawE5kxCNhvhOKy8LNvd/QWehP28IWgnL5mXG3Rew=;
        b=P0MhsdyMGZ3XJmzlSk4CllYXA1geVTZWmr2Fjyv88Q7ZPbHTwBOY5k2DAO10JT5OBplmOH
        AkBEeUvauITGmK6ZBJFuyrm00gpgRlP2bOcLdHV440gFQUtFiggkLxUePTWXmrNCKkpqhY
        EGBLCDf8ZfXprGt5SE+XdzM+LdOBAWV3F79mVQH6J9Ho+ErqTC05FGasNo8+wDhuEmugMM
        P2t52sXwv0DEpNOjNaTUYrGW2Nnu0EhVpz4IgSJ1QQ6q6zE2V6BXxF5ax4F47OMdGcjYSa
        OYxOfE1neZ7jzISDyTQOAr6lACPpVNakre4JdzAU23aukqgVknLj69Y+J4mtjA==
Date:   Wed, 2 Aug 2023 14:44:26 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>
Cc:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>
Subject: Re: [PATCH] mtd: fix use-after-free in mtd release
Message-ID: <20230802144426.2411bba2@xps-13>
In-Reply-To: <d9d56389-7409-79ae-6854-00ab8de7da4d@huawei.com>
References: <20230727145758.3880967-1-alexander.usyskin@intel.com>
        <ZMKJRNDoQV8p0DH4@smile.fi.intel.com>
        <20230727172013.7c85c05d@xps-13>
        <ZMKUJbl7kFOfgKGg@smile.fi.intel.com>
        <20230727183611.37d01f51@xps-13>
        <CY5PR11MB63660B9CE604C0CFF2E088DAED04A@CY5PR11MB6366.namprd11.prod.outlook.com>
        <d9d56389-7409-79ae-6854-00ab8de7da4d@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi zhang,

zhangxiaoxu5@huawei.com wrote on Mon, 31 Jul 2023 09:35:42 +0800:

> =E5=9C=A8 2023/7/30 19:10, Usyskin, Alexander =E5=86=99=E9=81=93:
> > Miquel, is this patch helps with your original problem of devices not f=
reed?
> >=20
> > Zhang, is this patch helps with your problem with KAsan? =20
> After this patch applied, the problem can still be reproduced.

Did you test my patch as well? Does Kasan still complain with it?

Thanks,
Miqu=C3=A8l
