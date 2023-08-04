Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDABC770643
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjHDQsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjHDQsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:48:06 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED62A198B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:48:04 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 49CAEC0003;
        Fri,  4 Aug 2023 16:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691167683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0cU9ENbCHDNBrym2EhNzJUF5RqsANfxJ7c9bMDP5JSI=;
        b=fFOxVYzN2JXmoVot41WaWR9E/3J8gerDMdVwjmar/38qNZZahpgnWUSjaxd6CZFJN3UfbV
        oTmAIpNW1Q6Sva0KK4o30tXpF6bPn0WdVoK7ZDsURfPH4YMfo3l0mDc6JB1NYA71vHJart
        qOYjZ4t/FRfstSaaYPmv3/02q3kSG9gvlBZ7DAJlk21XaKoh6mHLDqubJV0qkyWL1df6NM
        Z/bGs5pj7+G8GjOsKGDDYhNhNWAN872VVlclEBjUPhv6Zdw4XxmNw4XWQd3sOLAxdRYj/n
        2ASyWV/e72pza8asQs3FB6mGgSdwz01nG07/tcoMUiuaTUAOCxpaFGEE7yFKVQ==
Date:   Fri, 4 Aug 2023 18:47:57 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     oe-kbuild@lists.linux.dev,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH v7 5/7] nvmem: core: Rework layouts to become platform
 devices
Message-ID: <20230804184757.66bc6abe@xps-13>
In-Reply-To: <3a4aa779-f8b8-4178-8d65-b6aae9183fb7@kadam.mountain>
References: <20230801182132.1058707-6-miquel.raynal@bootlin.com>
        <b9040273-aca8-432a-83aa-b0d6b1b88529@kadam.mountain>
        <20230804173903.2b298cd3@xps-13>
        <20230804174625.4c27fe9a@xps-13>
        <3a4aa779-f8b8-4178-8d65-b6aae9183fb7@kadam.mountain>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

dan.carpenter@linaro.org wrote on Fri, 4 Aug 2023 19:05:20 +0300:

> On Fri, Aug 04, 2023 at 05:46:25PM +0200, Miquel Raynal wrote:
> > Actually of_nvmem_layout_get_container() already returns NULL if
> > CONFIG_OF is not defined. This helper returns either a valid pointer of
> > NULL. Where can it return an error pointer? =20
>=20
> This is from linux-next.

Ah! Ok I missed that one, we don't need this double implementation, as
of_nvmem_layout_get_container just calls a function that already has a
static inline counterpart in the of.h header, which returns NULL. I'll
make the change, thanks for the pointer.

>=20
> include/linux/nvmem-consumer.h
>    256  static inline struct device_node *
>    257  of_nvmem_layout_get_container(struct nvmem_device *nvmem)
>    258  {
>    259          return ERR_PTR(-EOPNOTSUPP);
>    260  }
>    261  #endif /* CONFIG_NVMEM && CONFIG_OF */
>=20
> regards,
> dan carpenter


Thanks,
Miqu=C3=A8l
