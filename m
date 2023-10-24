Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC4D7D5D0A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 23:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344383AbjJXVTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 17:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344348AbjJXVTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 17:19:10 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37C610DC
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:19:08 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6b497c8575aso4922966b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698182348; x=1698787148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bKh+O/PANGlG/qak+LU04NiuPPv63eV7oLEVO+FPPs=;
        b=Yiof7WKcSesV4TPDXHLle0fc1vLms8bvGTLEUXUyHxmwaVh9GnJqYmfcIOgvz7QxF4
         jpJIwuNbY1FGCV/N9DetRk44AUYSTUJ17Tm8e5ScyTI1Vpi4rjCVGLSASc37+KyzuBD/
         5RkIKUfKk03Fx8si3MPfiTSQm6+3Gx34ouEH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698182348; x=1698787148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bKh+O/PANGlG/qak+LU04NiuPPv63eV7oLEVO+FPPs=;
        b=SjdvBAtN1CZSpR75imdxfQsM6DWP/y3utf+NbMHJ3UX0ThdnwnkWyYpEJ0b3ZfJ1fJ
         k+3GRRZf3dlQmjwk7R66mDS5WZYyTIwWDyHm2vYsMn1OUPDNxvF2NJoEMi+q0m3n04PH
         rGto7PQIftgb1mIZuqOWVCmNT1ljTAljZRDJkInx7Eme/BnqV4HgT/VjqO6wLG4FZwls
         83sruCYJHWfi+c/TkLCd2q+q99rH62gfBdZeYIwe+LFEsT+DjASIm9T4wYV5VTODyc88
         k+1Xwyv6H73f3j0SlWSqJe66M9NwFnr4pH5+gz2ajFV+7YvFn4zQzipy6yE4eOcCP5MB
         y9cQ==
X-Gm-Message-State: AOJu0YweWLa+HHYAATyWSpd2inrAW+fq5nwCurrZdAhkQ3t1ye/TBZPu
        k9xl8AEDmmA43F70uSotchxEYg==
X-Google-Smtp-Source: AGHT+IHGLGRzlzjxbgpZEoNG6Q70od6GIZtk0kPFMN0s5WSitO5/SXqI8s8n50J7L7IYCLKn2sbH3Q==
X-Received: by 2002:a05:6a20:3951:b0:16b:79b3:2285 with SMTP id r17-20020a056a20395100b0016b79b32285mr4216060pzg.56.1698182348320;
        Tue, 24 Oct 2023 14:19:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g12-20020aa79dcc000000b006b24b99afd4sm8349691pfq.176.2023.10.24.14.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:19:04 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Justin Stitt <justinstitt@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] dm ioctl: replace deprecated strncpy with strscpy_pad
Date:   Tue, 24 Oct 2023 14:18:51 -0700
Message-Id: <169818232969.2100071.3919289615593947459.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925-strncpy-drivers-md-dm-ioctl-c-v1-1-f0bfa093ef14@google.com>
References: <20230925-strncpy-drivers-md-dm-ioctl-c-v1-1-f0bfa093ef14@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2023 06:54:51 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect `spec->target_type` to be NUL-terminated based on its use with
> a format string after `dm_table_add_target()` is called
> | 	r = dm_table_add_target(table, spec->target_type,
> | 				(sector_t) spec->sector_start,
> | 				(sector_t) spec->length,
> | 				target_params);
> ... wherein `spec->target_type` is passed as parameter `type` and later
> printed with DMERR:
> |       DMERR("%s: %s: unknown target type", dm_device_name(t->md), type);
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] dm ioctl: replace deprecated strncpy with strscpy_pad
      https://git.kernel.org/kees/c/0f3f34ea3798

Take care,

-- 
Kees Cook

