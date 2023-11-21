Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFBF7F3717
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 21:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjKUUFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 15:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjKUUFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 15:05:52 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE9BD45
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 12:05:48 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1f5da5df68eso1971551fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 12:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700597147; x=1701201947; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gOM9RKHgmvEognuoT2mihAVZYGmbf7+DM5clLXjwU9Q=;
        b=BOuFVD7fADDqrgn4G2OHVptKHm+nXE6k3t6NfWYNt2kltbw4m5ZcxC4Jowm8cOgv5m
         ie0rzz4wd0pj6HbzTF3r/Pdp2b7YXzuzIlX3NcgM/TgQE/iGa1US6vhdRMCi9v2XpBZo
         M0SYX/SLKtKPmcKExZppZgoEvy8KRSGx1WlmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700597147; x=1701201947;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gOM9RKHgmvEognuoT2mihAVZYGmbf7+DM5clLXjwU9Q=;
        b=Iqcdylg7hxWjSWx34Lmb9qdMfmEUfgPgodUzgX8CMzpiajvlxnAIwKzS/82cXU9deJ
         RQ3tGm2/vzTMosYJ1iHGJDRPIW2/0V4IwY9eFCanyeH5HKX4YpHwighlmU+ASccjjJKr
         D8C+aa2SrZQSso3fFpIiCCB3yEPC5TBjSSVKqfYX1wtgztukrJ4FPm3+LMQZ8G5vFEOo
         Gjg7LxnY8JPJJny23A1GuXaI3EKgflavrelnGrQaYfnpLcI07VudZnGAQla636ArMnjp
         FUHfnBqPmfsUPZENy6oDpW8F+HcxMFbX31DT8+f7z1t0YMHt7ObfCp3epaHOpaBR0d0a
         0QZA==
X-Gm-Message-State: AOJu0Yy5T08w9bFGrfkk3mSTPKEvWZIZTe+jxk2XA+bDUs0xCtgn1PZy
        Re1cTh1Nlax7MnSJaMII2TIuRZGX2E4v0cVV5OzKJw==
X-Google-Smtp-Source: AGHT+IG2Lzvp5y+3jot3b1hYmuCVyGCugXehBZHf+1LhhLvxsT3oTh+/4GJ1qxqx2rLL+cVDTTLjJg==
X-Received: by 2002:a05:6870:4d13:b0:1e9:b0fa:de48 with SMTP id pn19-20020a0568704d1300b001e9b0fade48mr413485oab.47.1700597147305;
        Tue, 21 Nov 2023 12:05:47 -0800 (PST)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com. [209.85.160.44])
        by smtp.gmail.com with ESMTPSA id l17-20020a05683016d100b006b87f593877sm1610241otr.37.2023.11.21.12.05.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 12:05:46 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1f5d2e4326fso2056495fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 12:05:46 -0800 (PST)
X-Received: by 2002:a05:6871:4417:b0:1d5:8fb8:98ef with SMTP id
 nd23-20020a056871441700b001d58fb898efmr450576oab.31.1700597145898; Tue, 21
 Nov 2023 12:05:45 -0800 (PST)
MIME-Version: 1.0
References: <20230111-uvc_privacy_subdev-v1-0-f859ac9a01e3@chromium.org>
In-Reply-To: <20230111-uvc_privacy_subdev-v1-0-f859ac9a01e3@chromium.org>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 21 Nov 2023 21:05:30 +0100
X-Gmail-Original-Message-ID: <CANiDSCvxZyFqR06a6eb22duyBMEt8yroo8H_Hpmid2vOy7ucVw@mail.gmail.com>
Message-ID: <CANiDSCvxZyFqR06a6eb22duyBMEt8yroo8H_Hpmid2vOy7ucVw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] meida: uvcvideo: reimplement privacy gpio as a
 separate subdevice
To:     Yunke Cao <yunkec@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari

Could you take a look at this RFC? Would be great to have your opinion
from a subdevice point of view.

Thanks!
On Wed, 11 Jan 2023 at 09:52, Yunke Cao <yunkec@chromium.org> wrote:
>
> privacy_gpio in uvc were added as V4L2_CID_PRIVACY in uvc video node in
> https://lore.kernel.org/all/20201223133528.55014-1-ribalda@chromium.org/
>
> Userspace applications often require to constantly poll privacy control.
> Currently, polling privacy control requires keeping the video node open,
> which prevents the camera from autosuspending.
>
> This patchset adds a separate v4l2 subdevice. Userspace access the gpio
> via V4L2_CID_PRIVACY in the new subdevice. Applications can poll the
> privacy control status without opening the video node and activate the
> camera.
>
> The non-gpio V4L2_CID_PRIVACY in uvc is not affected.
>
> Suggested-by: Ricardo Ribalda <ribalda@chromium.org>
> Signed-off-by: Yunke Cao <yunkec@chromium.org>
> ---
> Yunke Cao (3):
>       media: v4l2-ctrls: Expose v4l2_ctrl_fill_event()
>       media: uvcvideo: remove entity privacy control in the uvc video node
>       media: uvcvideo: reimplement privacy GPIO as a separate subdevice
>
>  drivers/media/usb/uvc/uvc_ctrl.c          | 17 -------
>  drivers/media/usb/uvc/uvc_driver.c        | 44 ++----------------
>  drivers/media/usb/uvc/uvc_entity.c        | 76 +++++++++++++++++++++++++++++++
>  drivers/media/usb/uvc/uvcvideo.h          | 19 +++++---
>  drivers/media/v4l2-core/v4l2-ctrls-core.c |  9 ++--
>  include/media/v4l2-ctrls.h                | 12 +++++
>  6 files changed, 111 insertions(+), 66 deletions(-)
> ---
> base-commit: 7dd4b804e08041ff56c88bdd8da742d14b17ed25
> change-id: 20230111-uvc_privacy_subdev-1e7a167e86eb
>
> Best regards,
> --
> Yunke Cao <yunkec@chromium.org>



-- 
Ricardo Ribalda
