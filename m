Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71D57DD058
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 16:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344741AbjJaPTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 11:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344689AbjJaPT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 11:19:29 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC38D63
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 08:17:56 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a7fb84f6ceso50751807b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 08:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698765469; x=1699370269; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VVokwlv4EgWjfwIfgjLNp6YdLR04B4foMomExEIuPtI=;
        b=dTlsYB7yCQNNPbKwCCL7jw3O6wasKIAfV4n7FQFi9wahbvoHBxC7N4N8IksVeS8QXu
         On+TNwr9yuyA2yMd+PrD5YpY8Ztto6aLskVthdgEVdOJyqpipbu8wREZ1VvLWCDmLt99
         so4dOIzPB6yOqXsDSeDqjzmnmB/Oab2bd61qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698765469; x=1699370269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VVokwlv4EgWjfwIfgjLNp6YdLR04B4foMomExEIuPtI=;
        b=TSKC31E1G6U/4Uv3o27W+uO71gYuS7xsroszsATzoBhoGKiaQj15/VoDmbJQ1vR7jm
         bQaQ43OLQ7IvoY4ebgC3fboOusBKsJDdUM2MAXDbsnuA/lssV3u1UKe2+DFemipuB9Ea
         /er9aGRl2kKAcAJ8LeEOdRWugTgugjc+joS5a9jyXI9x20uUW/euI0+auIoxfnSBpUpc
         g386aQA4279APEsWIghNLKqJV5KybpoyYdjG3i/reP59fIJcQPrVq922RghcpZidAF6e
         HNS+Ie/Cex5VZ/03Z4yHpzW781yJFV92K1z4430D/wSxhJOGb+4vqw/x4YP6y9vXPwoF
         Vu8A==
X-Gm-Message-State: AOJu0YxZOxx4M4mkcKHzCL2C+pN/6ail0JMymIxR7wkxmjIkDNz/hiVz
        4dPnayWJN5IPMSn0+5JGAJZocNxWkwmc+oZPMIHuHA==
X-Google-Smtp-Source: AGHT+IFKe4YagDmd1at7aanmi7ofKqUh3QCjbP4e2+xwuTZh0DNpik9W7OCq/p43vUvMc8UXHS7bf1HSWfY/9U03/HA=
X-Received: by 2002:a81:b143:0:b0:5a7:c72b:812 with SMTP id
 p64-20020a81b143000000b005a7c72b0812mr10331369ywh.17.1698765469004; Tue, 31
 Oct 2023 08:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231027212916.1035991-1-markhas@chromium.org>
 <2b8335a7-4b9b-825-c1b8-84158aaf2c42@linux.intel.com> <CANg-bXCcNPjmQC9vgd1JJcV4QoruhhbeEg8o=S9K-22kb746kQ@mail.gmail.com>
 <8f1b5075-6b12-4fa8-a173-804d4657415e@amd.com>
In-Reply-To: <8f1b5075-6b12-4fa8-a173-804d4657415e@amd.com>
From:   Mark Hasemeyer <markhas@chromium.org>
Date:   Tue, 31 Oct 2023 09:17:37 -0600
Message-ID: <CANg-bXA8zSJkO_rgDQCwEFxsFyXHO6Ad2eYwV2xGdxL_vCh04A@mail.gmail.com>
Subject: Re: [PATCH v1] platform/x86/amd/pmc: Get smu version before reading
 dram size
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Sanket Goswami <Sanket.Goswami@amd.com>,
        platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a patch in place that should address the problem you are
> mentioning. I will send that out next Monday after some tests.

Great, thanks Shyam! I'll hold off on pushing a patch implementing
what Mario suggested.
