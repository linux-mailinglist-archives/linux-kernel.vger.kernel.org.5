Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18207C74D9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379600AbjJLRet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347447AbjJLRej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:34:39 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5C544AC;
        Thu, 12 Oct 2023 10:24:36 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-27d18475ed4so1035835a91.0;
        Thu, 12 Oct 2023 10:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697131472; x=1697736272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yiYicO/CzyPKr38cwMsBZ+CV6emG+Kpc+1Q5AoAvQw=;
        b=CKZOGNuvaL7NqWMw5yTCbMkRSAEZtk/4kPy4agcjlspMPYc3txi3WpQWlWZGEWNZZR
         p3h5c/XxTzz59AYsvjfdZgHh2nR6otNgh1j7yNDW0+AyKG+RkKhzs89EE7ngLMVzPXTo
         dc0ofo0Yf/TM45bzFcfxhimkN9Xv9hkirom1Nu+zMmP3AYJToHa48VOuVJr+fiYtG71e
         sNSCBQNRwpdmWSLd8wkbSUqb/+3e00v/dT8WXy/l7NBhNfHGSxBih8DTB92gs2Ne6zWm
         lFeDRu+2NX1HCG0EnY24F8QL208erlyn+llaKHj4I5LlEyT8W4t+f+ODh1NYCuYFkj6z
         nH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697131472; x=1697736272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4yiYicO/CzyPKr38cwMsBZ+CV6emG+Kpc+1Q5AoAvQw=;
        b=c+5qGVfaHKjaThQKteiL6DJsupbmpHobnkHAs/9pdqLAtpwsbOKzx7bzlllAOktonp
         SLos2MYvgSF0MHfKvxVlQTjTlPOESJlhh1B/39lvwunEjbUdHh/Z3A7x1EwaR8laSlfF
         VpxUYO4Gu96H89hWZ1mDLfAbzXiK8WlqjoRrYZw0mNLgnTcTa3ryQWDVf1R+frAgEkLn
         J5p4C+pLPI2LHfjj+MBAy1E9yOjBMu3KD3+KbZk6ViNa7zrjE4n6qALjlyD0lMW6aIq6
         YcIIZF9zQEcnsN57kA1zi7K3bm1h633ZN8oG/UhlprHokx4hWMx4iz2tgzDgJzU9v1gN
         TuqQ==
X-Gm-Message-State: AOJu0Yw/uRYKAesCkIrLNlgDt62vIhfESN9iQcG0cRtTdztg3WtqfZoZ
        chfElE2aSEDo3ZbJqtHs2WEQTWx2mre0sNxwnKY=
X-Google-Smtp-Source: AGHT+IHLoBek2/++6oN9ioIWzSt//LtKh2Q3WBjKasG/NiQ1q6X2HJsyNvWesGIuzWFfQ2a9SqZ6mzF50Wqi3MF4BI0=
X-Received: by 2002:a17:90a:356:b0:27d:1051:83c4 with SMTP id
 22-20020a17090a035600b0027d105183c4mr4130501pjf.12.1697131472563; Thu, 12 Oct
 2023 10:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231010234803.5419-1-bwicaksono@nvidia.com>
In-Reply-To: <20231010234803.5419-1-bwicaksono@nvidia.com>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Thu, 12 Oct 2023 10:24:21 -0700
Message-ID: <CAM9d7cgE6vcB0Pi+585JKaddiRGOFkFFEiDP_FS-x6-2itVtfA@mail.gmail.com>
Subject: Re: [PATCH v3] perf cs-etm: Fix incorrect or missing decoder for raw trace
To:     Besar Wicaksono <bwicaksono@nvidia.com>
Cc:     james.clark@arm.com, mike.leach@linaro.org, suzuki.poulose@arm.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-tegra@vger.kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
        rwiley@nvidia.com, ywan@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 4:49=E2=80=AFPM Besar Wicaksono <bwicaksono@nvidia.=
com> wrote:
>
> The decoder creation for raw trace uses metadata from the first CPU.
> On per-cpu mode, this metadata is incorrectly used for every decoder.
> On per-process/per-thread traces, the first CPU is CPU0. If CPU0 trace
> is not enabled, its metadata will be marked unused and the decoder is
> not created. Perf report dump skips the decoding part because the
> decoder is missing.
>
> To fix this, use metadata of the CPU associated with sample object.
>
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
> Reviewed-by: James Clark <james.clark@arm.com>

Applied to perf-tools-next, thanks!
