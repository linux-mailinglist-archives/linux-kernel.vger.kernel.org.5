Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110337D11A3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 16:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377529AbjJTOd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 10:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377490AbjJTOdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 10:33:53 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C96019E
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 07:33:51 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C94A7C0007;
        Fri, 20 Oct 2023 14:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697812429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zZPwG1QrAqBLq23wnEyxrPXk3d8fu1E8yL0jWfm6ZX4=;
        b=IVVDGU/4ju4RloomC3TVhl6poOqo447GqE9kialVEV+1EUAbwOf3wpNP97tzIe+DfRl9JC
        MW6imyQzM2HcFGIOG+t3RVSwKcs5jkH74R8jNHHxznmOuP/9gFhkE4ypfvRoAW6zpkghyP
        YqJPQPpgB1515Fov8LwSy5amH/TXkv9+tjNjR6wsg2BHAj4EqVDzAIojmONee1EpXZNecQ
        m5bgzefIWvqBkM23swIYEitTpZcLkuJxVvnH/41MtStoI4HUneRuX1HwkfJ5JRykT/VyWL
        GTkWB3gU0P5syaaxmGbuk6/Ufk/30zeKB3yhtpUkgiWpjXHQXge7LlHuqpG23Q==
Date:   Fri, 20 Oct 2023 16:33:48 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Frank Li <Frank.li@nxp.com>
Cc:     "Zbigniew, Lukwinski" <zbigniew.lukwinski@linux.intel.com>,
        alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] i3c: master: add enable(disable) hot join in sys
 entry
Message-ID: <20231020163348.1752167d@xps-13>
In-Reply-To: <ZTKMyW939rB6sSKq@lizhi-Precision-Tower-5810>
References: <20231018205929.3435110-1-Frank.Li@nxp.com>
        <20231018205929.3435110-2-Frank.Li@nxp.com>
        <57efe6de-cf65-32ed-fd1e-a388e1676c70@linux.intel.com>
        <20231020154528.2f5f68f5@xps-13>
        <ZTKMyW939rB6sSKq@lizhi-Precision-Tower-5810>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

Frank.li@nxp.com wrote on Fri, 20 Oct 2023 10:20:57 -0400:

> On Fri, Oct 20, 2023 at 03:45:28PM +0200, Miquel Raynal wrote:
> > Hi Lukwinski,
> >=20
> > zbigniew.lukwinski@linux.intel.com wrote on Fri, 20 Oct 2023 10:55:27
> > +0200:
> >  =20
> > > On 10/18/2023 10:59 PM, Frank Li wrote: =20
> > > > Add hotjoin entry in sys file system allow user enable/disable hotj=
oin
> > > > feature.
> > > >
> > > > Add (*enable(disable)_hotjoin)() to i3c_master_controller_ops.
> > > > Add api i3c_master_enable(disable)_hotjoin();   =20
> > >=20
> > > What is the use case for having HJ enable knob in sysfs available for=
 user space other than for debug stuff? In other words, does user space rea=
lly need to enable/disable HJ in runtime for other reason but debug? If it =
is only for debug maybe it=C2=A0 could be move to debugFS? =20
> >=20
> > I don't think hotjoin should be considered as a debug feature. The
> > problem here is the power consumption which is higher if you enable
> > this feature (you need to keep everything clocked and ready to handle
> > an IBI) whereas if your design is "fixed" (more like an I2C bus) you
> > may save power by disabling this feature.
> >=20
> > A module parameter does not fit here because it's a per-bus
> > configuration. =20
>=20
> I agree. sys entry is more flexiable. and let controller choose better
> power saving policy for difference user case.

Maybe it's not the first time this case is faced, would you mind
including power management maintainers in this discussion? Perhaps they
might have pointers or even have the solution already.

Thanks,
Miqu=C3=A8l
