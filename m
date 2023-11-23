Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E540A7F68DC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 23:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjKWWLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 17:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWWLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 17:11:32 -0500
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F6E10C9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 14:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1700777494; x=1701036694;
        bh=1FSAtIYmUftMaxOldMoteCptRTxIkeeuJnWLHgIXrlA=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=cKWk6SyY7AK0lUuCp5Xn1fwoCcUc2EdFsBbzXNqYMgHpOlmoEFhqIx7LNPXCVydfZ
         hp8uUX5zJnqE9v/ix0YVj0RqzUUCHMvjOCeH2Xwd2xHH0McUo9+3qYY54YBj84GacZ
         pWI5jsjKxxLgTTePqS7y3u9F9k8ieFvYSl6Q6iK44gNmnWkWXB9Sy3Crf/06IaxflB
         N+kSQL2L8hcB8CWR5XWZrqB6Bu0trOXoYPLKmAlRKP1X1oQuAlUPc6Uvripwnl25Fb
         MZGqoGbgOMKE23vmgO0yvUp/CeMO2Lo1MNJHA1ZzK19jncMnk7Wwh95LC069Y4Wno8
         XFTP4BYoDTbUg==
Date:   Thu, 23 Nov 2023 22:11:14 +0000
To:     Javier Martinez Canillas <javierm@redhat.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org,
        zackr@vmware.com, linux-doc@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>, iforbes@vmware.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        David Airlie <airlied@gmail.com>, banackm@vmware.com,
        Rob Clark <robdclark@gmail.com>, krastevm@vmware.com,
        spice-devel@lists.freedesktop.org,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Airlie <airlied@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mombasawalam@vmware.com,
        Daniel Vetter <daniel@ffwll.ch>, ppaalanen@gmail.com,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v6 0/9] Fix cursor planes with virtualized drivers
Message-ID: <xUgaKXv4lqgCEWWlB4KRGx-yLXefTg-uXEdXaTqAhOTxC4G7bCILTK9SH6ymdmMMBLooAl3_Kdvl5JXeUA8Hofg9PcCMBhPWhVhnCoxvgqA=@emersion.fr>
In-Reply-To: <87y1eqc5qk.fsf@minerva.mail-host-address-is-not-set>
References: <20231023074613.41327-1-aesteve@redhat.com> <-ngmaSLF2S5emYjTBWcLRNzvJRoe_eZ-Nv9HQhE6ZLuK8nIE2ZbfVh2G2O2Z41GoIFIRpts0ukEtFXUx8pNAptmrZBhlXxaQGykx_qCZ_9k=@emersion.fr> <CADSE00KW4+hpbAbZAusBngq5FYSa067wYJCGeetqngWRJaD9Kg@mail.gmail.com> <87y1eqc5qk.fsf@minerva.mail-host-address-is-not-set>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, November 22nd, 2023 at 13:49, Javier Martinez Canillas <javie=
rm@redhat.com> wrote:

> Any objections to merge the series ?

No objections from me :)
