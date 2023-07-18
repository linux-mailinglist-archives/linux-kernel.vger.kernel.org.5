Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E8775778E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjGRJOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjGRJOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:14:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB27D2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689671623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+xQVi+1cDmFmde3CAW+nWXYiT+uL7nvMDhCcLeOQ/Lc=;
        b=EMfdh5kLYAkyDx28m0P6kam7oeKUy/Z4UOQ3Msn1dg7Y5Tj+GgAijxjSwF907aMXJ0bl+f
        alTVxQ+8eaKxGRISpb/i/VVDLpHxGOIQeksYHhrF/B+A8C/mvGg2a0Bbmf4IFc6kVGWT+H
        FL0sHu5xwgVSoF0wYn/j/mG5fbmcFTI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-5qKrOne1M0S5NgVmeOrWrw-1; Tue, 18 Jul 2023 05:13:40 -0400
X-MC-Unique: 5qKrOne1M0S5NgVmeOrWrw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-635eb5b04e1so13822456d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689671620; x=1690276420;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+xQVi+1cDmFmde3CAW+nWXYiT+uL7nvMDhCcLeOQ/Lc=;
        b=Fe3Bcy8pXlMC+iL3mc9x1IWNQ/qLx75DHzk4EO3ln6NSfRolEtwW3xCV8g6EEMNaz+
         HfKcZL8LXQmVhP8gb67KSryNmhVSdb49X8kyacyKFcIjKhgua5zgi7xZ9hQHLwh7tvkA
         iEgsz/AHpyntGJrZ7zK9XvHiBwyMiEpIaMMr8+wJPo/QN4YF5mrYSoEop/wYB48YdfJe
         k6DNT4ls2Rj2xKiz0ke1R8vZVoHL3nP0uWHZO5fe31IkIg4i+IgviYtW6OWz4GwgXjls
         N2dFT/vS50COFrQq+n/joHCqqCNnTJ4HUsJ9Ej7Ru0/PdOrN+tDBM+xBys2JPh5X2WWl
         Au8g==
X-Gm-Message-State: ABy/qLagMaUhTeYBuwaxgWJagRS7I0WnNpr/67kvBepyVfHkH4Whwc5l
        xTuH2vMHnAniQvNih1oFsU9UqKmpT+PBwHJD8s9GDd63TfqQUJUwsCS6ceUSMSuU87UIPxZ1dgM
        i0n/N5AvlwZe4Y8zVNloCrdUM
X-Received: by 2002:ac8:5e51:0:b0:400:9ed9:7267 with SMTP id i17-20020ac85e51000000b004009ed97267mr18485994qtx.3.1689671620363;
        Tue, 18 Jul 2023 02:13:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH0jzXpTnM/0x9IlIDIkxfyPZicW+zEoqycjC6QNj3AX2IVOjMMKoY90EFmlcoV29fqvdjw8g==
X-Received: by 2002:ac8:5e51:0:b0:400:9ed9:7267 with SMTP id i17-20020ac85e51000000b004009ed97267mr18485980qtx.3.1689671619973;
        Tue, 18 Jul 2023 02:13:39 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id hf10-20020a05622a608a00b003e4d9c91106sm513473qtb.57.2023.07.18.02.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 02:13:39 -0700 (PDT)
Message-ID: <164e816460523a9b54b06b1586f89b3bd2d09fc9.camel@redhat.com>
Subject: Re: [PATCH net-next v2] net: dsa: mv88e6xxx: Add erratum 3.14 for
 88E6390X and 88E6190X
From:   Paolo Abeni <pabeni@redhat.com>
To:     Ante Knezic <ante.knezic@helmholz.de>, netdev@vger.kernel.org
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 18 Jul 2023 11:13:36 +0200
In-Reply-To: <20230714160612.11701-1-ante.knezic@helmholz.de>
References: <20230714160612.11701-1-ante.knezic@helmholz.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-07-14 at 18:06 +0200, Ante Knezic wrote:
> Fixes XAUI/RXAUI lane alignment errors.
> Issue causes dropped packets when trying to communicate over
> fiber via SERDES lanes of port 9 and 10.
> Errata document applies only to 88E6190X and 88E6390X devices.
> Requires poking in undocumented registers.
>=20
> Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>

It does not apply cleanly to net-next. Please respin. You can retain
Andrew's Reviewed-by tag.

Thanks!

Paolo

