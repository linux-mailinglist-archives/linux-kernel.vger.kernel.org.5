Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D5278EE2B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 15:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbjHaNKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 09:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbjHaNKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 09:10:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A382BC;
        Thu, 31 Aug 2023 06:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1EC09B8229B;
        Thu, 31 Aug 2023 13:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6DAC433CA;
        Thu, 31 Aug 2023 13:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693487414;
        bh=Tx7w8FI/pLlA3uFq5GwLia/GR2hgOf2fgjsGhZzl+sk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iGIOjWFaoc2o3+D9pAiu+tKS35mKl+S0jaHg8kypiV3yFq21+2GVITjISQhWfpAdv
         bCcRVTXC++Bq4bS/DAS9XrufWeAlZf2Z50hk/OFSA35ImHW9DBOmxOEwrl/m/BmpkM
         9JveujHt2tgFXJjAiqLHHXP5lvXIKa+o6txV7VcCQN8qEnP6WAMnbiUlfU9KjpZ5tr
         YCKbxu71rqllAEenrYcz/5UKmN2n+DVJm0UHlFflCh5sIdP4j7KIOCfHFVJ+XdfFTD
         rDByGBAUoq+TwyJkqDDPbYuC+W2PsII4MlqFItMcYoshcRexmdKL+gG55NqyXn8W1X
         h9Ot5ry6gTl+w==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6bcade59b24so692956a34.0;
        Thu, 31 Aug 2023 06:10:14 -0700 (PDT)
X-Gm-Message-State: AOJu0YzeH3h4OxsxfGVO42ZgqsV7r0pqSmQjKzTUrghg0huT+GEbPXte
        KfcwZtgJhGpQpE9Anlvy3btH4foE/HGW53AUzwI=
X-Google-Smtp-Source: AGHT+IG8i3WbP148tu9tcR8zh6tpPXpF5XXUrFtO3K953V/IifgX01VT9BiDyttjPL/yAvgZZMXCRFBxgo8FSTUsb7I=
X-Received: by 2002:a05:6830:606:b0:6bd:bba9:2d63 with SMTP id
 w6-20020a056830060600b006bdbba92d63mr5298073oti.9.1693487413878; Thu, 31 Aug
 2023 06:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230825-strncpy-habanalabs-combined-v1-1-daa05a89b7e3@google.com>
 <202308251513.0F6BF9FEE6@keescook>
In-Reply-To: <202308251513.0F6BF9FEE6@keescook>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Thu, 31 Aug 2023 16:09:47 +0300
X-Gmail-Original-Message-ID: <CAFCwf12yWnz6wP+3Th=QiTkeMhiPjn6c4sg2b3-2fE55w3pyEQ@mail.gmail.com>
Message-ID: <CAFCwf12yWnz6wP+3Th=QiTkeMhiPjn6c4sg2b3-2fE55w3pyEQ@mail.gmail.com>
Subject: Re: [PATCH] accel/habanalabs: refactor deprecated strncpy to strscpy_pad
To:     Kees Cook <keescook@chromium.org>
Cc:     Justin Stitt <justinstitt@google.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 1:13=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Fri, Aug 25, 2023 at 10:09:51PM +0000, Justin Stitt wrote:
> > `strncpy` is deprecated for use on NUL-terminated destination strings [=
1].
> >
> > We see that `prop->cpucp_info.card_name` is supposed to be
> > NUL-terminated based on its usage within `__hwmon_device_register()`
> > (wherein it's called "name"):
> > |     if (name && (!strlen(name) || strpbrk(name, "-* \t\n")))
> > |             dev_warn(dev,
> > |                      "hwmon: '%s' is not a valid name attribute, plea=
se fix\n",
> > |                      name);
> >
> > A suitable replacement is `strscpy_pad` [2] due to the fact that it
> > guarantees both NUL-termination and NUL-padding on its destination
> > buffer.
> >
> > NUL-padding on `prop->cpucp_info.card_name` is not strictly necessary a=
s
> > `hdev->prop` is explicitly zero-initialized but should be used
> > regardless as it gets copied out to userspace directly -- as per Kees' =
suggestion.
> >
> > Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on=
-nul-terminated-strings[1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en=
.html [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
>
> Thanks for the consolidation and refresh. :)
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook
Pushed to habanalabs-next-6.7

Thanks for the patch,
Oded.
