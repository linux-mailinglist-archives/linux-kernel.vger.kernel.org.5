Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768677BF62B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjJJIj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbjJJIiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:38:54 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4304A111
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:37:54 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-323ef9a8b59so5127342f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696927072; x=1697531872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLeTodDQewItkg/3d7H1CuYJRje+YY0rVU81amFMi/s=;
        b=q4z++7IlmicA1SzAb8PKiz4P6/ZbCC9PFe+gPsyo2topH8ywC66aW0VQ/RLCEfDPyo
         LDdjyZWbEz2z3xPOrapKmEK6UtseOBoPNBuHItI3wIKivV/DxDuZaC5SLlJXJd2eu0i5
         PTOXUWRMPkbbrkLYhFwrem15rV4DO4wH+kFY9rQFWZFZBgmLPrDQK0a8XrJrnrdzWEqv
         OSLgd+8sg5o7s3Q53sUtpQauE6cOsSQOS53+T7Ury54ZCp8JZdsdgrl70PK2PAJYj8l7
         Qs1MfAmrezPGMmM95ese9VW8Y2pwMWLkKQ+g4wMRprpJ3ESlNJD8DksFyH7Cp+TQDEVa
         jCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696927072; x=1697531872;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CLeTodDQewItkg/3d7H1CuYJRje+YY0rVU81amFMi/s=;
        b=YBKpRmqCW7+q8wAwdwoHOJpsihQLCX0Ew2/OrgeqCA5X2Vt8Ew3bbNNfC6pQdW+4oZ
         sG3DaycPxexPVFdVXndvCYyczOP2htftnITqaHLQdwpnagm3yRgPTARRohgWN7YifEjb
         /HH+uXwVliENrGfpOd9q5G2WJk5ZVfh8HpUjVKTsCN9FSDrn67K4EOyN3vXiC09Mxl9b
         TUYYOn0r3+Ml8kc3VgbUQ507albXvsKmLjn9ga/piQ1E78DBeWjz3VRW6Iuj/dEMpied
         hwjOM8OVbOTWog90OWSCm3txNYJpzS6ia5RCiOsX+wPTat4r+hKW3Pk3tAVMtAqxCz/8
         H+Cg==
X-Gm-Message-State: AOJu0YwlRHSOBcYEZkemMmT5aGJiwOLZFjxx+HG8zSeMbcYRNkARiAet
        oSb/g7nN1xEM5EO/rrF5Ou6AdA==
X-Google-Smtp-Source: AGHT+IFOwKpu6jatNoo0Jz/ERH/tyMjrEWInTl16AWeunSBiQXAFTRMYQCdIRBIOjD2ktfFVdn73Vg==
X-Received: by 2002:adf:e3d2:0:b0:32d:65ab:2228 with SMTP id k18-20020adfe3d2000000b0032d65ab2228mr316418wrm.11.1696927072565;
        Tue, 10 Oct 2023 01:37:52 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id s4-20020a5d6a84000000b00327bf4f2f14sm11983147wru.88.2023.10.10.01.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 01:37:52 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     linus.walleij@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, Ma Ke <make_ruc2021@163.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231007033105.3997998-1-make_ruc2021@163.com>
References: <20231007033105.3997998-1-make_ruc2021@163.com>
Subject: Re: [PATCH] drm/panel: fix a possible null pointer dereference
Message-Id: <169692707182.2632460.7509507129195879705.b4-ty@linaro.org>
Date:   Tue, 10 Oct 2023 10:37:51 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 07 Oct 2023 11:31:05 +0800, Ma Ke wrote:
> In versatile_panel_get_modes(), the return value of drm_mode_duplicate()
> is assigned to mode, which will lead to a NULL pointer dereference
> on failure of drm_mode_duplicate(). Add a check to avoid npd.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/panel: fix a possible null pointer dereference
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=924e5814d1f84e6fa5cb19c6eceb69f066225229

-- 
Neil

