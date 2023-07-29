Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA961768022
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 16:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjG2Or1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 10:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjG2OrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 10:47:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9DCA8;
        Sat, 29 Jul 2023 07:47:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D065660B7D;
        Sat, 29 Jul 2023 14:47:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CADCC433C7;
        Sat, 29 Jul 2023 14:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690642042;
        bh=4QtF6lrRgUwnTmI2MNTr84Bvaa6ZwfztTVrfiBKNbXA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OtjQ3nulgnQWZUhPsyFOvWRz0pyJA0BsQpYDhMpqXBwtYOm27IsES5XAyKp9qsmbz
         HwV99wN2Ut6xpk5uhB2FhKRXiQBl8nlfyba4Yzs30R47UtreDa1HVp8iIbfEBLc3a2
         ynMD3SoePwWNToz5iSHDXMtyuDMU+CT523ZpQcJj/AlOVAEywltvYXV7cD+J9Z7M1h
         VIGbd5be8rQNBawXCd1/7rtA5LH9Nn887u+8Yo6e+6tUiMyGnmiZCwgKDBMt2SxpwZ
         T2jgiypjLGIscMedE44aENEk31V05QjBSQEx/JoeLoGnsmxkB7GtgDHiEZN7RC+6KS
         KaY14MejPwpEw==
Date:   Sat, 29 Jul 2023 15:47:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>
Cc:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] iio: imu: adis16475.c: Add delta angle and delta
 velocity channels
Message-ID: <20230729154726.49b9a86b@jic23-huawei>
In-Reply-To: <BL1PR03MB59925DFDE7AE86BF3B78AD8D8000A@BL1PR03MB5992.namprd03.prod.outlook.com>
References: <20230719123152.309624-1-ramona.bolboaca@analog.com>
        <20230719123152.309624-4-ramona.bolboaca@analog.com>
        <20230723133636.4b8fc5f1@jic23-huawei>
        <BL1PR03MB59925DFDE7AE86BF3B78AD8D8000A@BL1PR03MB5992.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 10:23:02 +0000
"Bolboaca, Ramona" <Ramona.Bolboaca@analog.com> wrote:

> > On Wed, 19 Jul 2023 15:31:52 +0300
> > Ramona Bolboaca <ramona.bolboaca@analog.com> wrote:
> >   
> > > Add support for delta angle and delta velocity raw and buffer
> > > readings to adis16475 driver.
> > >
> > > Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>  
> > As noted in my reply to Nuno's review, the question of channel type
> > is still unresolved.
> >   
> 
> Hi Jonathan,
> 
> I think Nuno already offered the definition from the data-sheet, but let me
> mention it here again for context:
> 
> Delta angle:
> In addition to the angular rate of rotation (gyroscope) measurements around
> each axis (x, y, and z), the ADIS16505 also provides delta angle measurements
> that represent a calculation of angular displacement between each sample update.
> 
> Delta velocity:
> In addition to the linear acceleration measurements along each axis (x, y, and
> z), the ADIS16505 also provides delta velocity measurements that represent a
> calculation of linear velocity change between each sample update.
> 
> Seeing how we cannot find something more suitable, do you think it would make
> sense to add these new channels to IIO: something like IIO_DELTA_VELOCITY and
> IIO_DELTA_ANGLE and specify in ABI docs that these measurements are relative
> to the previous sample? Or do you have something else in mind?

Yes - I think we need these new channel types to avoid inconsistent use of the
existing types.  In the documentation I would give a little context, particularly
around the common use of these being to simply sum them over time.

Jonathan


> 
> Thank you,
> Ramona Bolboaca
> 
> > https://urldefense.com/v3/__https://lore.kernel.org/all/20230720193457.27
> > 2f02a9@jic23-
> > huawei/__;!!A3Ni8CS0y2Y!52Dhq_Yj9srV_lE8JgPysp2b3Lbg9U2w94VIGTMa8
> > 3hepJgv-NCnFWomV83Ud5C3TGp3tMMI0IDVRYZV5N8$
> > 
> > Thanks,
> > 
> > Jonathan  

