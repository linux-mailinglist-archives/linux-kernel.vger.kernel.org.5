Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBAA7919B1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 16:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240439AbjIDOcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 10:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjIDOcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 10:32:04 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2806194
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 07:31:59 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2082060004;
        Mon,  4 Sep 2023 14:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1693837918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W3BueW+5ouWvJdqGn30lncsv3tQGn2v6ujqAYNE8/yQ=;
        b=B8zsWGfaRq+NOXojK+ZQW9UC5UkQP+7AMKTkP44ekYibvMe8O0rKxFED0FyK0QngteUilU
        M1L/aPpI2YzaxJVrTJx4qog1Li4fyXycnvBg1ky9JL8pBJUuamU0ySrWuR37Wjt4kne19F
        XHqC6Y1aXFPMlauWCFk8Y71VhAd11FuIP0ULlX/D47pTkaiTeZ48UBNdf5gKfBL+6a+x2p
        OM3M7S9rPrGvTXiuwKJCVCmvafJK+WM+isK3sBN6XGMdfZKEcCZ0tbICwWLHhpDVFIf33s
        MevfU36nI3nbJWLBnHbHVjeRPtmhapP8mUrPwZOtSlJ876DORsFVWRcr6/DB1g==
Date:   Mon, 4 Sep 2023 16:31:56 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <kernel@sberdevices.ru>
Subject: Re: [PATCH v2 2/2] mtd: spinand: micron: fixing the offset for OOB
Message-ID: <20230904163156.4bdb8c06@xps-13>
In-Reply-To: <90a53eda-bbeb-dffa-0f90-6fd229f555e6@sberdevices.ru>
References: <20230822122534.872646-1-mmkurbanov@sberdevices.ru>
        <20230822122534.872646-3-mmkurbanov@sberdevices.ru>
        <20230822153556.630e65b9@xps-13>
        <01925ff8-1d19-a729-429a-89866fad319f@sberdevices.ru>
        <20230823104143.760cc5bc@xps-13>
        <f873d775-cda9-302d-a651-0113c7c7dc84@sberdevices.ru>
        <20230823133956.0a505a20@xps-13>
        <ccf3099f-0e10-a87c-be83-4a414f01dca7@sberdevices.ru>
        <90a53eda-bbeb-dffa-0f90-6fd229f555e6@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

mmkurbanov@sberdevices.ru wrote on Mon, 4 Sep 2023 17:20:59 +0300:

> Hi Miquel,
>=20
> On 24.08.2023 12:35, Martin Kurbanov wrote:
> >=20
> >=20
> > On 23.08.2023 14:39, Miquel Raynal wrote:
> >> Hi Martin,
> >>
> >> mmkurbanov@sberdevices.ru wrote on Wed, 23 Aug 2023 14:33:57 +0300:
> >>
> >>> Hi Miquel,
> >>>
> >>> On 23.08.2023 11:41, Miquel Raynal wrote:
> >>>> Hi Martin,
> >>>>
> >>>> I don't think the four bytes have any "bad block specific" meaning. =
In
> >>>> practice, the datasheet states:
> >>>>
> >>>> 	Value programmed for bad block at the first byte of spare
> >>>> 	area: 00h
> >>>>
> >>>> So only the first byte is used to mark the block bad, the rest is
> >>>> probably marked "reserved" for simplicity. I believe we should keep =
the
> >>>> current layout because it would otherwise break users for no real
> >>>> reason. =20
> >>>
> >>> I agree with you that this can break the work of users who use OOB.
> >>> However, I believe it would be more appropriate to use an offset of 4,
> >>> as the micron chip can use all 4 bytes for additional data about the
> >>> bad block. So, there is a non-zero probability of losing OOB data in
> >>> the reserved area (2 bytes) when the hardware chip attempts to mark
> >>> the block as bad.
> >>
> >> Is this really a process the chip can do? Aren't bad blocks factory
> >> marked only?
> >=20
> > Actually, there is my understanding, I=E2=80=99m not sure exactly.
>=20
> I tested with an offset of 2, no read/write errors were detected
> (including read/write to OOB). But I don't have a flash chip with
> factory bad blocks yet, when I find such a flash, I will report the
> results.

Ok.

> Do I need to send the v3 of the patch with only first commit ("correct
> bitmask for ecc status")?

Yes please, with Frieder's comments fixed.

Thanks,
Miqu=C3=A8l
