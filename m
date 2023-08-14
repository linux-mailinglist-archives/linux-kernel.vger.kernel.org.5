Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885D277C32E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 00:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbjHNWCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 18:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjHNWCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 18:02:16 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B5C10F2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 15:02:14 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-6459a873237so13729166d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 15:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692050533; x=1692655333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mwYC5y1w73XOQ+JQk9ab6pGT6BUQ0RtEcIvzv4bMiU=;
        b=dQh/oXzkAnSIrtDNcO6e5Rb9npBij+9Md2DDJpcMtgE5V8lMFH5fyRAzbjpcFej7ny
         cX6f8nkjPkuSyNj5VM+zEv3PTAUz1cC+taVXXaoZ0oS3wMR3Veesfh8jNGbx3l8U9MGF
         Dpxwc9pmNuy4v4KqYuUXV75tqbymxCExp0+zuG8YJ4erqXWQmWTUdjNvCCZkyDP0NgeY
         X0u4oa0AIVXaRRaVlJZWADjWzeknVdpAHD6sTaG8BzJoBAIcFze2JrJgFesxQULRYkzI
         smkBvJOcq9uvREbJklJeMrJQ8VEQ0TnnG2TwXZFtC2AKVNL27f2ThO/PQeAHZ9Xl9H5/
         zDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692050533; x=1692655333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mwYC5y1w73XOQ+JQk9ab6pGT6BUQ0RtEcIvzv4bMiU=;
        b=J3DohDcHz47FJtv4p7alQ25SLV48LOMMG5HbuXjhnoZV/ZY19Xr2CUyo9Fzgc9hDwO
         Q90WoVuzFmfqBxblL+GB/JQGXFk94iGxRP6CCfJOVg6QoDviPtR9LA+abY1gO/2vIEJs
         6zgsf4OT5pLzoogPOq3Z7OawDdgHvMVLlse/MAg5c+IWWIfqdwVIG1PWOGWNxw/VdfYQ
         DUkrhpgRCr6bmXYCfLJhhDRCyxtCUgVNa1RGp8iMtJr7erwpUEKWXIz96kLLDMkUeDdr
         ohaZIuN5GabFVti8nM0oxb0gucsg5iIS9azLPFMOBG/CA9nRLrHumnyJdvEPscWnAKWj
         icBQ==
X-Gm-Message-State: AOJu0YxVLjsxgbupXTYRvD31Gq1EPY2i+ijQ1ogzUt3mII3ml14leVDj
        3GQqfbYAuAe5tj9kklznuvk9P5+NTTua7i0X0VwZAaVMjcOd63Mc+ETsRg==
X-Google-Smtp-Source: AGHT+IH6wivOZHs37QX+AYcNTOVvJhfdvZs2Fe6L0Y0X/5iqhnofg4KtZ94BhgTJQ2RzI2U8jlPbdkhVTSh/ljoySZ4=
X-Received: by 2002:a0c:f444:0:b0:647:27ee:4853 with SMTP id
 h4-20020a0cf444000000b0064727ee4853mr2741059qvm.5.1692050533527; Mon, 14 Aug
 2023 15:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230810104749.164827-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230810104749.164827-1-krzysztof.kozlowski@linaro.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 14 Aug 2023 15:02:02 -0700
Message-ID: <CAKwvOdm5kiTho-b1yagjjCGX5-=HGKutGZR3NkDeYh5RRBHJ_A@mail.gmail.com>
Subject: Re: [PATCH 1/4] ASoC: aw88261: Fix unitialized ret of aw88261_reg_update()
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, llvm@lists.linux.dev,
        Andi Shyti <andi.shyti@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 3:47=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> There is a branch in if() clause where aw88261_reg_update() could return
> uninitialized value.  Pounted out by W=3D1 clang build:
>
>   sound/soc/codecs/aw88261.c:651:7: error: variable 'ret' is used uniniti=
alized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>                 if (aw_dev->prof_cur !=3D aw_dev->prof_index) {
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   sound/soc/codecs/aw88261.c:660:9: note: uninitialized use occurs here
>         return ret;
>                ^~~
>   sound/soc/codecs/aw88261.c:651:3: note: remove the 'if' if its conditio=
n is always true
>                 if (aw_dev->prof_cur !=3D aw_dev->prof_index) {
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Thanks for the patch!
I see this addressed already in -next:
https://lore.kernel.org/all/20230808125703.1611325-1-arnd@kernel.org/


>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  sound/soc/codecs/aw88261.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/aw88261.c b/sound/soc/codecs/aw88261.c
> index 82923b454dd4..fddba2f2de41 100644
> --- a/sound/soc/codecs/aw88261.c
> +++ b/sound/soc/codecs/aw88261.c
> @@ -636,7 +636,7 @@ static int aw88261_dev_stop(struct aw_device *aw_dev)
>  static int aw88261_reg_update(struct aw88261 *aw88261, bool force)
>  {
>         struct aw_device *aw_dev =3D aw88261->aw_pa;
> -       int ret;
> +       int ret =3D 0;
>
>         if (force) {
>                 ret =3D regmap_write(aw_dev->regmap,
> --
> 2.34.1
>


--=20
Thanks,
~Nick Desaulniers
