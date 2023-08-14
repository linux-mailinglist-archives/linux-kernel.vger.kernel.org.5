Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FB877BBD1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjHNOgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjHNOgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:36:12 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CFAE4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:36:09 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99c47ef365cso604790366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1692023768; x=1692628568;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PBDCBE7RjzqM9AaRqPKjVsz1pmTLNzetZlkAiDCCFV8=;
        b=aKolWpzf4l9+QDgsAeY0gM8tEjkEyCV+kCwYa/50PaJImWPKOa41rkaVr5azj4gr7K
         PabnzaQ0abzGvjLZ9FDR1nFhbk5ePpiH7q7KFkvpHgFLYoOyDptUGbOR/zHzeOqIU8zE
         NNcuj9Fm3jL/CvmYynDlzwx9YiY+CToyGd2z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692023768; x=1692628568;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PBDCBE7RjzqM9AaRqPKjVsz1pmTLNzetZlkAiDCCFV8=;
        b=X56htKxBH1P2MFTzYi6N3p2F3+Z/c2Qms971ucqE26iHDZ5Jm4ycGsbdiyEZEJvHSd
         6nMRyQSgvMGKwz+MaO/eFhIc/MbWwfLARBN7sjpiUYMekQ8VlLdd6u0nlJY7nDt9j9Ox
         3RGkSvGF3KbClRBIIbsaVRmwBufEL+RtXfcpJwEd4ybO2m+c6g0ZlOm+3HMNO/Hl/et3
         vMFI93VnGfFU3yUY298BtsHM2Gd/2BxEqXrbHDhVCp2LoPJajq1uWwkggAmJDRcv2IJx
         5f8YH5HUHXROOumcL0Mk0eb7akyUHrOKbzP6keoN5VEYSIWvaqvX5JUoeKUNDWtj3K2y
         2vWA==
X-Gm-Message-State: AOJu0Yx93XTMnc7u8qSP3xyTb0RtgpzOHzErcf/X5fm6mhsxfvTJNWRm
        zXF4G50GRneGxRJ2IcJeaTkCYrWlkHzbrzECfzKgYg==
X-Google-Smtp-Source: AGHT+IF/y/heO1ofQIbx2QpS88H0OEjtNIFBQZDYvDnoh0N/orizg8tGcrkQm20pKYRtBgIvmsFKUu2GsA5/m5ZA7Og=
X-Received: by 2002:a17:907:7883:b0:99b:e464:bf49 with SMTP id
 ku3-20020a170907788300b0099be464bf49mr8157072ejc.51.1692023767874; Mon, 14
 Aug 2023 07:36:07 -0700 (PDT)
MIME-Version: 1.0
References: <4f66cded234462964899f2a661750d6798a57ec0.camel@bitron.ch>
 <CAJfpeguG4f4S-pq+_EXHxfB63mbof-VnaOy-7a-7seWLMj_xyQ@mail.gmail.com> <ZNozdrtKgTeTaMpX@tycho.pizza>
In-Reply-To: <ZNozdrtKgTeTaMpX@tycho.pizza>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 14 Aug 2023 16:35:56 +0200
Message-ID: <CAJfpegt6x_=F=mD8LEL4AZPbfCLGQrpurhtbDN4Ew50fd2ngqQ@mail.gmail.com>
Subject: Re: [REGRESSION] fuse: execve() fails with ETXTBSY due to async fuse_flush
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     =?UTF-8?Q?J=C3=BCrg_Billeter?= <j@bitron.ch>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2023 at 16:00, Tycho Andersen <tycho@tycho.pizza> wrote:

> It seems like we really do need to wait here. I guess that means we
> need some kind of exit-proof wait?

Could you please recap the original problem?

Thanks,
Miklos
