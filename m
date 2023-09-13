Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5A879E7C3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240356AbjIMMRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240320AbjIMMRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:17:06 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CF819A8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:17:02 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d815a5eee40so469211276.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694607422; x=1695212222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfQQwZ9QXlwCfkvMrB5PtlK3NyN0a7PbMHdl8QtueJU=;
        b=d7v2m6g+cvTuiLDMKjcfTIFxqPTQ9wQekPpoDGiu5pJGBOozU3d0Fe22cec3XDCAEz
         f+PI4Bo9QJWhyNVzTqA+LIGPBYM+qHT/xdf3zR0/fLWvP0LFH+8Ua4tHfZfrm9cY7AIx
         GDIYW4yUgCQVFPHh8Cc4OWvBTpgzK9mNNE73Ltj+FdOwpuka7/et7K4JyT+HXMssV3Ng
         GVFMAwaNoeX3ryB/xdNRC5noynlN2CC4Ia66NHi2TSrgMOEUbfBPqSUPZKoTUPDrZ2g6
         IPVjaL+7wgUfIO+tUR6+Go7BzEe9CeO5DREmKC/w3nK8VJ6MirsDA9S9Zd9K1jvsSIAk
         zUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694607422; x=1695212222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfQQwZ9QXlwCfkvMrB5PtlK3NyN0a7PbMHdl8QtueJU=;
        b=D/7X7AwHVsHZREK0c4dey5FltgyBRyx2ab8wqp5Q/Y/BmWRpAEoarRrfeF1/M/Bbj4
         FY8Epf0BHo1Kbb+OBr9KCC5wMHNFQks+N9h9ASwg+fMxSkAlJMxlPfnmOp27Wq/3eX9v
         cQ1b10FjEhPblddNbgOPiXmBf0KHewS8UyHWfyn2EC70vkabYOxspPblK57uHj/VbYEi
         8DhDCeOSeYbZRC+yEV0vRbVHksq3C7AAAJJ/BWxQDVD6UnNT3dfzzfGptzyhD2XLY3oR
         pH1Wo55bPgMFcBrT9bQaOE1HOM23r0ESXi9Kk1TH7qA1t3JVO2dJ+5lPC7+BwqYcIN1i
         hZew==
X-Gm-Message-State: AOJu0YxCgDTg6GVZqRpmuzziUPI+h3+V1qKDwiF1fv4ZVdx8O7ffTaRB
        5Ihfa8uh3XTwntRaHGKMlseYtYHMYdasiXonmYcocw==
X-Google-Smtp-Source: AGHT+IFm3rFZSj+QwbYojC2gzl0ngNMAHTYSXxUXT3k5la+jtBKlX1+dnXxk8PlrXVLAN6wq4iWuHk+s8gkGXsraWNA=
X-Received: by 2002:a25:7451:0:b0:d7f:d510:bbf4 with SMTP id
 p78-20020a257451000000b00d7fd510bbf4mr2198433ybc.52.1694607422023; Wed, 13
 Sep 2023 05:17:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220617123003.4048328-1-windhl@126.com>
In-Reply-To: <20220617123003.4048328-1-windhl@126.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Sep 2023 14:16:51 +0200
Message-ID: <CACRpkdasN70mBgqPozrckfvoOenRAk5t25y+bc0schuSkF9_Xg@mail.gmail.com>
Subject: Re: [PATCH] arm: mach-versatile: Fix refcount leak bug in tc2_pm
To:     Liang He <windhl@126.com>
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 2:30=E2=80=AFPM Liang He <windhl@126.com> wrote:

> In tc2_pm_init(), of_find_compatible_node() will return a node pointer
> with refcount incremented. We should use of_node_put() in fail path or
> when it is not used anymore.
>
> Signed-off-by: Liang He <windhl@126.com>

Patch applied.

Yours,
Linus Walleij
