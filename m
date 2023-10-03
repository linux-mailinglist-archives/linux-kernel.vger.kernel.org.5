Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856FD7B653B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjJCJPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbjJCJPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:15:51 -0400
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0F4B0;
        Tue,  3 Oct 2023 02:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1696324542; x=1696583742;
        bh=nen70pPfYsFQ+/UgrSVi4kwZXiA3ZJJ5IdOzvntgq2Q=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=WuPyHewUmOZtWm/VDzREBchcdW8oW4JlA35XXoglek6TeI4z5d3mQZrxyO+a404yc
         NtnygGO4bukAEK/La5SfEncEt1MlfEFlqBE+7spGznfTNxzPLNO7Q9/pgOu/fV5Nkr
         tjwoWt+8oW9h2MIkPh6MXaTHLvc4z1sWROoUFjqFMYpAPDpFIY/s6EM3tZ7V8fNVUs
         CMPSK5cqn5PkoNeYuhwhh6micd5tAOnmg1799rKSdosjz2ZWKTgOYtPFM0cM64kHYd
         AwWgtlbSzmiQIyR13yufqAqEhAyQUwuwwVHao91DK+Z38BpID8tQHN+DZwfTTywBtr
         lY9z+DQHduoeA==
Date:   Tue, 03 Oct 2023 09:15:31 +0000
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
From:   Simon Ser <contact@emersion.fr>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Janne Grunau <j@jannau.net>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        freedreno@lists.freedesktop.org
Subject: Re: [RFC PATCH v1 03/12] drm/connector: extend PATH property to covert Type-C case
Message-ID: <cnx7qh-CGEiQ1zPNo1th85qcZYrw8fcWRQgb3a66yrdVvLrf8nZEmKjshodkHdWVdBS4Qzgj0FegzZLUhj890KSuZCe9l8ZC2Or9CZIlT2s=@emersion.fr>
In-Reply-To: <20230903214150.2877023-4-dmitry.baryshkov@linaro.org>
References: <20230903214150.2877023-1-dmitry.baryshkov@linaro.org> <20230903214150.2877023-4-dmitry.baryshkov@linaro.org>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, September 3rd, 2023 at 23:41, Dmitry Baryshkov <dmitry.baryshkov=
@linaro.org> wrote:

> To facilitate this, reuse the 'PATH' property, which was used to
> describe the DP port in the DP MST configuration. Use either
> 'typec:portN' to point out to the Type-C port class device, or just
> 'typec:' if the corresponding port can not be identified.

Typo: should be "typec" without the colon I think?

What are the situations where the port cannot be identified? It seems
weird to use the PATH property in that case.
