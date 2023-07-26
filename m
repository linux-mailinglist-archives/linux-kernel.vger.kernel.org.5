Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C335E76369E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjGZMps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbjGZMpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:45:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F6FDB;
        Wed, 26 Jul 2023 05:45:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 748B261AF8;
        Wed, 26 Jul 2023 12:45:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2264EC43395;
        Wed, 26 Jul 2023 12:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690375544;
        bh=qAP+AniKBMF/3k1CBzf3DK40Wu2ameAg/4VKPtXezEk=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=uHsTkRYK+Vp8yA1fXMbRLvQyZ8owgaWKk0VI7ubenlB9WG3JNnTtW2Z0oxce6IyD9
         gyn++dztbKQxgpV7N+TdBuq4Lv8njQVGwEvmVS2dnuW1PiuYwpgYENDQsmCwWwNT73
         mBV31OcfLDNPHVifZ6Tw3VEotxT0Rvv4g28vQln+U//syOeBBCktniFvLC3JC28h/e
         m7QIlV/EmlwfgrxyyOcCtUlQbTykNgdXSA4z0G3PevtxHue22VwJkwRVNwwuKYkNaX
         Kv5J0ZIDIjdP5qrLmHdv5/7ZIHHEqp2QPf8cIvukxblOMtWF+ymOUDhSJMBq/r/GED
         t0YrfrnSkPYjA==
Message-ID: <b173a6b5a016b7f0fce751cd8a05c2d3.mripard@kernel.org>
Date:   Wed, 26 Jul 2023 12:45:41 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Douglas Anderson" <dianders@chromium.org>
Subject: Re: [PATCH v3 00/10] drm/panel and i2c-hid: Allow panels and
 touchscreens to power sequence together
In-Reply-To: <20230725203545.2260506-1-dianders@chromium.org>
References: <20230725203545.2260506-1-dianders@chromium.org>
Cc:     cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, hsinyi@google.com,
        linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        yangcong5@huaqin.corp-partner.google.com,
        "Benjamin Tissoires" <benjamin.tissoires@redhat.com>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Chris Morgan" <macroalpha82@gmail.com>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Frank Rowand" <frowand.list@gmail.com>,
        "Jiri Kosina" <jikos@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Neil Armstrong" <neil.armstrong@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Sam Ravnborg" <sam@ravnborg.org>,
        "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 13:34:35 -0700, Douglas Anderson wrote:
>=20
> The big motivation for this patch series is mostly described in the patch
> ("drm/panel: Add a way for other devices to follow panel state"), but to
> quickly summarize here: for touchscreens that are connected to a panel we
> need the ability to power sequence the two device together. This is not a
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
