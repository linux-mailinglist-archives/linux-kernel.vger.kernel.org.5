Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFE07BE8D2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377237AbjJISCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376857AbjJISB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:01:58 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67D39D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:01:56 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso57919951fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 11:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1696874515; x=1697479315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIBVQXsnA0W0erqiHcGTS0gNQWv81FUdQVlHJTQQf1E=;
        b=WhCTEDaIUqBIMs3KFSQ8yzatL7D+AdVRPsAONP4cowP8Ui9fKLCIr/ZQLFqPos2JiF
         ubqDrwIKJDfOm+F8oM4Pn2VbzvZnQiOc8/JLzC4rZOz7B6n7P36lmm/y1Yoc/ABgb1Oy
         dzrxmW+fpv1GMvDZR6JfAYIdEPNdllC1NVYTOfM9Bmk+nIENPj93QggAkhih7qQ+rmJu
         CRuPXOB8WN1mY/SCu9IQ9RGotKnbsCSvRSmOPhBSeHFIgxm/PPPH4grz8vFkUZRe/7q0
         vWQPOCbbBITZzn4tNPW1gp9crvHSIJsl1lTzvN/Pkb0PVe4l1FCDAXyVz/r6tD2J3kO9
         4yPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696874515; x=1697479315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CIBVQXsnA0W0erqiHcGTS0gNQWv81FUdQVlHJTQQf1E=;
        b=JyqR07JyzoYLw1rS0chigXRcil8pGUHw9SlZsyU6xuDr2imwW4EXZkt9r8b9qMzGRG
         ILKCftONglxP1WDAxX4Xcg4BxGxhqPqtaT/PoqtSW+UGDn5tOYFSZXyAya+IXna+SM4G
         ijukMrL7x7/yevfxSIaW6IcK0qhahSEVqYVJNSyVn+nB0kYf3EbcIq6LVloQtj2sJgik
         6C1pefum32roXW4BssJXZtzRAFb786FEAjaQiKKyGSSMRQJlrl712z3MbJCRQZ1gcys6
         b786kyGfPxQmx9AbJbJoWXvZ2W3VPWUrscWG3vdqzJ50SNGTVu64HPXk5swN92DKsIPN
         tR4g==
X-Gm-Message-State: AOJu0Yz2mq0lQ2hp0J6hmWlIRSQU+hzIkFMocvnF5cLEXNJh0R44yy9u
        hxX6IbP/xuwfuvEiwos4cwQ5GjsPkNUgfKLOQBKG+A==
X-Google-Smtp-Source: AGHT+IFyGgxuDPoZfAhdkd0KyG5vilYB/PEYGfiCygdIA1BUI/RGecyrUsLLaOQzqtRvqfF6Xgx0AY3Jocgh/Bk8CM4=
X-Received: by 2002:a05:651c:10e:b0:2bc:c650:81b with SMTP id
 a14-20020a05651c010e00b002bcc650081bmr13486770ljb.15.1696874514922; Mon, 09
 Oct 2023 11:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20231009165741.746184-1-max.kellermann@ionos.com> <2023100943-anew-choking-5954@gregkh>
In-Reply-To: <2023100943-anew-choking-5954@gregkh>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Mon, 9 Oct 2023 20:01:43 +0200
Message-ID: <CAKPOu+_CEJH0zfk5PQU5dxFY8ZiYjFvvAG2GXPM_3Fr2_om8Xw@mail.gmail.com>
Subject: Re: [PATCH 1/7] drivers/rtc/sysfs: move code to count_attribute_groups()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 7:24=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
> What 3 different purposes?

The variable gets initialized 3 times with different (unrelated) values:

1. count old rtc->dev.groups
2. count grps
3. allocate new rtc->dev.groups

This coding style is confusing and error prone. The code gets simpler
with this patch, because the cognitive load of understanding a
"count_attribute_groups()" call is lower than reading the "while" loop
and figuring out why it's there.

But I really wrote this patch because after making "rtc->dev.groups"
const, I cannot any longer assign it to "groups", because that
variable must remain non-const.
