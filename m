Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5327C736E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379584AbjJLQss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379580AbjJLQsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:48:46 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BC7DE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:48:44 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c9d3a21f7aso9983255ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697129324; x=1697734124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zj94NuVMRyygdkOW8mvq9Nen4maWkMgZsmZqNR+8rw=;
        b=bRTOFj4fSA056yrQKskox7o7RyuI3GNwUJPIzG55g6Vb1Vj52nUkqQhnJo4fRkVQZp
         BQdiwdDAotjrg1oO3PqN4zr9BORHv9s5+pLpCKdN+IPZ2CV23Ab/nQujySzvosvML9TL
         jxeSSVnjvDrn1e+T0a7dc/Ii+mk2RpVKRd34I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697129324; x=1697734124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9zj94NuVMRyygdkOW8mvq9Nen4maWkMgZsmZqNR+8rw=;
        b=qFgK93aT4JITorjdBV2kNgE4uRLlrD04Hv7R+5MoJjSNhXAjDGHZbmAUn1ojcpLUti
         v5zx+LoXwQHtpntuB0gyYA3rCWcxWfgTtqUr2Klc4xfAtmUb2Tuy//qbI1ArlbvRsSlO
         axt+a3nhpleLvJa9pDldFjrBYRm93magfSueiHkG4ynilnMieeEbv3r08nW3V19WumNi
         Wy8pfHSXFjv8t+DRbxZ5xXS5354SB9DmhiN3OOZLjOKMJHZoVJkxpb3t44875oW/qONh
         yRuaBEAv93pmzLg/PeG/oTPA/LZSLj9dlrR59Z4Oq7RhOkTsBQhW7XVeoKINYoTTEIGA
         EpDw==
X-Gm-Message-State: AOJu0YzPYagUQx0J2fghRHBZuqUjvOrGpPur7mWaGSjE0owsF4X14gsL
        idBe+QFlKGg68iQfudYf0o+EnQ==
X-Google-Smtp-Source: AGHT+IF831rt9uwN8FV+a7yFdX158syIhIfsDP9+BmIbnBUGEesMv6egJHZONGeGkhVAAiy8eu5gZw==
X-Received: by 2002:a17:903:11d2:b0:1c7:2697:ec0a with SMTP id q18-20020a17090311d200b001c72697ec0amr28084231plh.30.1697129323902;
        Thu, 12 Oct 2023 09:48:43 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902ea8400b001c5076ae6absm2204778plb.126.2023.10.12.09.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 09:48:43 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     Kees Cook <keescook@chromium.org>, tony.luck@intel.com,
        gpiccoli@igalia.com, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pstore/platform: Add check for kstrdup
Date:   Thu, 12 Oct 2023 09:48:41 -0700
Message-Id: <169712932001.5350.10182418867498473478.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623022706.32125-1-jiasheng@iscas.ac.cn>
References: <20230623022706.32125-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2023 10:27:06 +0800, Jiasheng Jiang wrote:
> Add check for the return value of kstrdup() and return the error
> if it fails in order to avoid NULL pointer dereference.
> 
> 

Applied to for-next/pstore, thanks!

[1/1] pstore/platform: Add check for kstrdup
      https://git.kernel.org/kees/c/a19d48f7c5d5

Take care,

-- 
Kees Cook

