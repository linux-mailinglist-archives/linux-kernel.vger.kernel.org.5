Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEB27BF634
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjJJIkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjJJIkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:40:11 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC8311C
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:40:08 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32157c8e4c7so5352671f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696927207; x=1697532007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5V8neVpY2GyLdSJsnZ8MOddhcYp6sdc0BYbuhT9I1jQ=;
        b=Rla+HRJR4uNt057FNJ4pzabPt5gobkC9EYVQU7cow/olgk6KpSujFIn/h9jgR3k1TG
         Vh6gEIRmQeKbqsp1uN9nhzxUC/aAXdEQMSAkETpnGjSTZcgaaniSS5XjENOYkzi9fvk0
         OhmbIjSJIbWT466LCp1CUwErYTyFmvZ4hxBYjjCljfryUGbBKDxk6g0eb4tI5FW6QoLH
         5dVt9UY8oHCf5vrT45MtIB7BKJwlEzeZ6j1u3x4ZUdlYBa8yJ6NFaLbslABOSbtU1RKD
         RHxeuz+scIsFjD2aqKuIh0YjQpw2GtNlL9gwwTuh5qUI+hrzEpiovJbwW+xyiIK4L5Lz
         rosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696927207; x=1697532007;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5V8neVpY2GyLdSJsnZ8MOddhcYp6sdc0BYbuhT9I1jQ=;
        b=SelFkv6xXLwRJxYMRev/i7zfvvJEape0NZR94e6Yhf/et9DEC3wDu7suiCmsUZdStl
         ddIFH1S2RDEqwp0qi5q9vs2tb95OszFU1uLJckNt7+9lfn7OIUdmpOt9cwhr28NFGcDg
         jyTeQq61ZeBHBEsXu3H2HpoV/zz07PeyjeJT9VjYWAYL9cRhIh4ZbJKBldkYontfN5GH
         dFnoAgv9U/tuPksXigXsIgAN1QMT63o5x04cbH6GfuJ6YEMmE/hZUfNGJhfnH1OE0lhI
         EKLUZFRCn6srvKg7jRXnvZhUAi3jizcY6VU/01Jb4UCMUNu/ipQb/Cz9IPwZfJ99oxOR
         mv9g==
X-Gm-Message-State: AOJu0YxjDp8RxDhXjSpc88apu1Qk7MpQldJ9A2TECJORz97O/mFEgYzI
        ZYQNbzJTOn65byEYnp/KAHQgWg==
X-Google-Smtp-Source: AGHT+IH1kmpxEfIe7fVGzRzvDNu56x2D7KkVclXW4oI19nKrGRc3frP0Z8AyVAk1RdaBj0q63jEwVQ==
X-Received: by 2002:adf:f48e:0:b0:324:8239:2873 with SMTP id l14-20020adff48e000000b0032482392873mr16993689wro.37.1696927206711;
        Tue, 10 Oct 2023 01:40:06 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id h9-20020a5d5489000000b003179d5aee67sm12052874wrv.94.2023.10.10.01.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 01:40:06 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     quic_jesszhan@quicinc.com, sam@ravnborg.org,
        yangcong5@huaqin.corp-partner.google.com,
        Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20231007064949.22668-1-zhouruihai@huaqin.corp-partner.google.com>
References: <20231007064949.22668-1-zhouruihai@huaqin.corp-partner.google.com>
Subject: Re: [PATCH v2] drm/panel: boe-tv101wum-nl6: Completely pull GPW to
 VGL before TP term
Message-Id: <169692720597.2649526.6802678685318841336.b4-ty@linaro.org>
Date:   Tue, 10 Oct 2023 10:40:05 +0200
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

On Sat, 07 Oct 2023 14:49:49 +0800, Ruihai Zhou wrote:
> The sta_himax83102 panel sometimes shows abnormally flickering
> horizontal lines. The front gate output will precharge the X point of
> the next pole circuit before TP(TouchPanel Enable) term starts, and wait
> until the end of the TP term to resume the CLK. For this reason, the X
> point must be maintained during the TP term. In abnormal case, we
> measured a slight leakage at point X. This because during the TP term,
> the GPW does not fully pull the VGL low, causing the TFT to not be
> closed tightly.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-fixes)

[1/1] drm/panel: boe-tv101wum-nl6: Completely pull GPW to VGL before TP term
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=258dd5e6e65995ee85a941eed9a06708a36b1bfe

-- 
Neil

