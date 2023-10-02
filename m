Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E177B55F3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237777AbjJBOlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237678AbjJBOk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:40:59 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F271AD;
        Mon,  2 Oct 2023 07:40:56 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40566f8a093so135545335e9.3;
        Mon, 02 Oct 2023 07:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696257655; x=1696862455; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=azI3yMPzAcZmIPttwUHbyoUesdGWRU/mZo7qOrVX4uo=;
        b=Awys0X+6qkqBpJzHF5m69Dx8KHQoCbp7b7MfMJg88Q40LRWh9D5DxAcqDU3l14bFNx
         LGkgtqsOJ25mujXU932Z06j+ROGj7c5rc9MdE9Mw1F7tA/Cl5C9l/fXiQLz2yE9GtPvU
         jxwz5pL2eN7D1xC1mXiuzg6wzZZ7/P8F20zoM3txx22V0z/4o8XmVyb75TPFtt4GTKP/
         XGb00B+8+gfnUtAqkTEt7OgWVCSya4aJLYdJg6dpLXYANFhc7B40E+bS9tjwoNIUGe1/
         8cvWALfVSKjiBVPEzlxx7PFha+9Bzo/AyrG1sj8IVn4zNO3yF9scfK/Mj48mpq+E86xw
         Xw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696257655; x=1696862455;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=azI3yMPzAcZmIPttwUHbyoUesdGWRU/mZo7qOrVX4uo=;
        b=TsIgK7bVroSIA7uzShZ0d1cgCPoFaVs3SblwDi73u4MXQHbrbTmkZ1vbNyN0vR431d
         5eQhBFUNK+S83HJfSuxiIyp1M/RQPrxbmfzorO7AaVcusy4xZjImfMpMyBfWbZGTIiS8
         0Lz8iUDjqyv3rs8ZIo+nRkyu67fpxEa9I0CfwQOa0wOidwZSaGqyWpTOqWEkMP+6qw/i
         Kufbh1NtbAzMHjOQ5fy7D4x0SCcYT2N4lwUIdB058Cgmb45gczsWABW56cCLG0ouplSV
         FCIRznhfPJrD6LSvmM+za+38fKVdxtPIj7KN2YWhUqJOLr6nP0vZtd4eKZdU+CdGSciW
         a6sg==
X-Gm-Message-State: AOJu0YxWUaKtdxOU9UFNMfYZg+xNs0xxjklXfdR1YYA9aABBsZN2uBfu
        k3PQrC+0gfwv17vA5nep0+M=
X-Google-Smtp-Source: AGHT+IFd6dQCn3B8wzH7CSRqASEUv2KLZebwoQpArOJDfRuQLN2exBUpc3vzblS8nwJVvP4Z+0dbxA==
X-Received: by 2002:a1c:4b18:0:b0:404:7659:ba39 with SMTP id y24-20020a1c4b18000000b004047659ba39mr10632000wma.16.1696257654545;
        Mon, 02 Oct 2023 07:40:54 -0700 (PDT)
Received: from yoga ([2001:638:904:ffe5:5742:c50f:bd0:6aa6])
        by smtp.gmail.com with ESMTPSA id j17-20020a5d6051000000b00326f0ca3566sm5902303wrt.50.2023.10.02.07.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 07:40:54 -0700 (PDT)
Date:   Mon, 02 Oct 2023 16:40:47 +0200
From:   Sven Frotscher <sven.frotscher@gmail.com>
Subject: Re: [PATCH v4] ASoC: amd: yc: Fix non-functional mic on Lenovo 82YM
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Mark Brown <broonie@kernel.org>, git@augustwikerfors.se,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>
Message-Id: <0SOW1S.YTFHPA95XPTN@gmail.com>
In-Reply-To: <28e38593-4861-4d61-b27d-994328ea4e82@amd.com>
References: <20230927223758.18870-1-sven.frotscher@gmail.com>
        <46560887-0b6e-42ac-96c3-b4dbc1d7cb61@leemhuis.info>
        <4fa7d39d-dc34-4550-97fa-2b089f364cca@sirena.org.uk>
        <0a3feafc-b843-420a-9b04-c835f8210c1a@amd.com>
        <048d9715-9cb2-4bc0-b8b0-5e30a0db54c7@leemhuis.info>
        <28e38593-4861-4d61-b27d-994328ea4e82@amd.com>
X-Mailer: geary/44.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo, 2. Okt 2023 um 09:20:04 -05:00:00 schrieb Mario Limonciello 
<mario.limonciello@amd.com>:
> I'm not positive, but the only way we get a full list is from Lenovo.

In order to be totally certain, yes.
But maybe the non-quirk check can be expanded to also cover (some of) 
the affected Lenovo models. As I said, I'm open to provide some 
relevant info from mine if someone tells me what "relevant info" means 
in this case.


