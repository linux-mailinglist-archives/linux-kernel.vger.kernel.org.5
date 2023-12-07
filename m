Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F26807D82
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441949AbjLGBBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441847AbjLGBBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:01:43 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6FFEE;
        Wed,  6 Dec 2023 17:01:50 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50bfa5a6cffso134385e87.0;
        Wed, 06 Dec 2023 17:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701910908; x=1702515708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+rXWANny0uHO6nzvjRs3/MCtnMqv7CRSnXsSEhy7sY=;
        b=WC/7EC55Tj0Ou8PbSnl8DdmwV11Ce8zbo/ZW1kQ2DKWp4ge902cWgWJKNJtoxvQfCx
         Bsn6ETtRJwi/qa+oHYVp6VUWnIhiqeV/FvVZw+hpXbw3onFaVontgpMEYyduXlX8jECj
         B6R95a1AjTVALf+XnN+jxGd6LVFCbY3w0KwgjoGqXSOB5pOicYTFhwHGrmSxnMFnrKwS
         LQv6l2InRCyI4FJpcqXQKdat5LAKrPWM7dRxI8WuDf2IFL7RlIojdovb7+5VGdzQIUpY
         dmSt/HOYAFHzmGyGEipO8MrLHkor2wdsj1CldLWCHpuCgk8FrkvrgA9IPE6VJC730DHW
         XrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701910908; x=1702515708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+rXWANny0uHO6nzvjRs3/MCtnMqv7CRSnXsSEhy7sY=;
        b=Ir1kKyY5SCVoKxLOhdp7W8yCoSPmkrZpKmHX52jZKwYWOCtn6b0J9m1hz2gCTH/wG0
         QV/pVmrRZLCPLX0abBsCHTaV2zZLHseWy/V7bvKROU+OigB9VC3eWlm3NjoWlXAYC0+f
         z5DTPH3t2QPvTjGWS+DsY/kgePqYsSNGlhwTb4zNdSD39qPRkOmAz5G3M6vRO5DSrsxE
         5654kTYi7q9vFz26URBnTWnbhx7mYKXQEvI4RLKX0npLjy+Wf5K91j7CmlTJW0MPT/Kc
         kGOMWaRA6CjWW420XZLBGAfL4X4u7CNjcGReR3P79IDIQiSQfvDHCcMG2F5Cbj9//sUS
         Sksw==
X-Gm-Message-State: AOJu0YzhRHSr7nCkhfKlhJys0wEt9jN9PZke/GLZgpkscRYz8jMZ73MW
        mUreWrkoZCx51KztccsYTt/kO8afeZpyEFwd48g=
X-Google-Smtp-Source: AGHT+IHzckmNKtnZ6eOoTsOs5qzRVqSfymWQafrRaRBqut1JkaNqKTmN853YKpOXutnsE06Us3WYqsyaEY388hz5RGY=
X-Received: by 2002:ac2:44d6:0:b0:50b:e750:dd99 with SMTP id
 d22-20020ac244d6000000b0050be750dd99mr1007855lfm.38.1701910907996; Wed, 06
 Dec 2023 17:01:47 -0800 (PST)
MIME-Version: 1.0
References: <20231120083559.285174-1-ming.lei@redhat.com> <ZXEUyH/38KeATuF4@yury-ThinkPad>
 <20231206165453.613dbe57555f41ab4b9b0acc@linux-foundation.org>
In-Reply-To: <20231206165453.613dbe57555f41ab4b9b0acc@linux-foundation.org>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Wed, 6 Dec 2023 17:01:36 -0800
Message-ID: <CAAH8bW-F6-uRHQ=c-C2pez365DbdRWn3izB9EmfBzvS+UHG3-A@mail.gmail.com>
Subject: Re: [PATCH V4 resend] lib/group_cpus.c: avoid to acquire cpu hotplug
 lock in group_cpus_evenly
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>,
        Guangwu Zhang <guazhang@redhat.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 4:54=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Wed, 6 Dec 2023 16:41:44 -0800 Yury Norov <yury.norov@gmail.com> wrote=
:
>
> > Although, it's not related to this patch directly. So, if you fix
> > zalloc_cpumask_var(), the patch looks good to me.
> >
> > Reviewed-by: Yury Norov <yury.norov@gmail.com>
>
> Thanks.
>
> I just moved this into mm.git's non-rebasing mm-hotfixes-stable branch,
> so I'd prefer not to have to redo it at this stage.
>
> Let's do these things (with which I agree) as a followup patch, please.

Sure, I can do that, and append to my series.
