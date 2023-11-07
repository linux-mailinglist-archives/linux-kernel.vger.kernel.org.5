Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55227E3C64
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbjKGMPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbjKGMPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:15:02 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACB9448D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 04:11:26 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d9ac9573274so5846347276.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 04:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699359085; x=1699963885; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qBsaoWhr2znf8wvyVHsUac05BAGwf4F6oqcvXZtUp/8=;
        b=iXMkBoQoLgWKkzBZiOv+sDzqltnXDA88Ik0w9dbJytsRyMYtCb0LG2wDl94RFq/lVJ
         AmXh3VGPX17KdiZuCsbS5NAp6CH8XeRfEowFcbuIan1DkNJpQK3HI1eRlPwZRDT4AZC/
         orlK4K34LFGBC5Q6GgQzdbQBi2cfbAtTAbwVSjQKSWPJWPZXtB09YTahdZ/4CDJFI/jL
         Dy/OBTD+Nw007JpCtsK5+Z3Jb9QQNT4/rrUIyxo8TKqx6R/RB15IaH520MYQ9Z0GEDgh
         AfhU4j+Yca9KansunGFkshE9e5T6FtrTickKD+1lUoPlH05uV9ujA5bgU9ZsKxWbCF7N
         N/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699359085; x=1699963885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qBsaoWhr2znf8wvyVHsUac05BAGwf4F6oqcvXZtUp/8=;
        b=OjaN1Z9NcS0RFCsNrM8utMINcRwKBLKDuqqoCva8FIH33P9lOzuopm3bEGh7hoWjbE
         4GzdDcJCXJkhwG+AtfPw58LR68GugNgtCc8g2HEFdmQSnLkuYnc4I5dWCdcyC16wt5P4
         1/oG7zJxifanRXaUC10eQaN35XwfS4Fst3pghc0qHedQpx9LcGro38IZUuZSjckXhjQZ
         O8OL29TQa+RAB19/bLuogIvf12vqxfzMrL+zVNH3Bqy4wqMkTrcoox7gofcg5YoJin3R
         OtulGRJgW7PwvhPMcYPSX+Dg5qfgnz27edAewZ1O+Ll/9Zj6i9QQQ6XkxFZSdz8Z/0qO
         kb2w==
X-Gm-Message-State: AOJu0YxkbEtLxYIpLikNdlSTXzJN3DyPBTcjZdg7VMXNMNY6oYh8jib9
        3skm4uQj8i/luAlt6cM5hNyW7XzDB7wxHoabc6egkg==
X-Google-Smtp-Source: AGHT+IHDMrKkSc1YppgWblP5EWz8Z1JpAjj1O5XSYjWz9AyzWl+KPwEz68afvy4+rSnZBmueG6VR2NfhaMpio9halj0=
X-Received: by 2002:a25:1955:0:b0:d85:abce:3f43 with SMTP id
 82-20020a251955000000b00d85abce3f43mr26728461ybz.38.1699359085155; Tue, 07
 Nov 2023 04:11:25 -0800 (PST)
MIME-Version: 1.0
References: <20231107095741.8832-1-victorshihgli@gmail.com>
In-Reply-To: <20231107095741.8832-1-victorshihgli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 7 Nov 2023 13:10:48 +0100
Message-ID: <CAPDyKFrr91qxxdYLiC4jeL+igYmJXpcfqvV1svWW-o7y4d9Kqw@mail.gmail.com>
Subject: Re: [PATCH V3 0/2] mmc: sdhci-pci-gli: GL975[05]: Mask the replay
 timer timeout of AER
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        SeanHY.Chen.tu@genesyslogic.com.tw, kai.heng.feng@canonical.com,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2023 at 10:57, Victor Shih <victorshihgli@gmail.com> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> Summary
> =======
> Due to a flaw in the hardware design, the GL975x replay timer frequently
> times out when ASPM is enabled. As a result, the warning messages that will
> often appear in the system log when the system accesses the GL975x
> PCI config. Therefore, the replay timer timeout must be masked.
>
> Patch structure
> ===============
> patch#1: for GL9750
> patch#2: for GL9755
>
> Changes in v3 (November. 7, 2023)
> * Split patch in two patches. One patch for GL9750 and another for GL9755.
> * Add fixes tag to corresponding patches.
>
> Victor Shih (2):
>   mmc: sdhci-pci-gli: GL9750: Mask the replay timer timeout of AER
>   mmc: sdhci-pci-gli: GL9755: Mask the replay timer timeout of AER
>
>  drivers/mmc/host/sdhci-pci-gli.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>

Applied for fixes and by adding stable tags, thanks!

Kind regards
Uffe
