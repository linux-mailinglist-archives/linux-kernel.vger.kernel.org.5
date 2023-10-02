Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF597B5392
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237288AbjJBNA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237285AbjJBNAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:00:55 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3B8B7;
        Mon,  2 Oct 2023 06:00:52 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3226cc3e324so15356066f8f.3;
        Mon, 02 Oct 2023 06:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696251650; x=1696856450; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ovbV2eys6IIdOiXHS9kD3zODjwel8FxTC6gNW0c8hfc=;
        b=msMykvTUadAxYHwVlY1UmDO28bkZMN2URKGyesQB2YO44rYi+G9vgYTOAKmHqqMwQt
         R2oBwOwmxZXEhaN30Y1KNOvLwP30T2N5CsamsFIAPE0Bw9PyHFEMbG9qe36PmTzZ1UmV
         66Qj0gjpwvEfOI1Ou/jLnz5bSDXq0Wnq1Z0XbCyALuv8+X2WZ1ruHg9vse3Ia3VFDOJe
         ZbGtdDzODmhnt6ziZQMr27ABGmE/AA8jARFqLihMsK8fjbmf1DqITdETuCW8/NQGlz8q
         MRyOUXAwRpi+MCM2iJ2wxE59kp+do4A4GoYsZKePSBxERZK8VK9aYHpo12YAlmpBzpt3
         +CJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696251650; x=1696856450;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ovbV2eys6IIdOiXHS9kD3zODjwel8FxTC6gNW0c8hfc=;
        b=ZVHv0HCnycJLV46jKoVVNAR/a1wdfzLsT5pCx6tbdA83ZAv9qoTZc/b7/JrIgNebxM
         FPRwVzub+TcK26DNiQlxqH+RScdkH/rKVn9qN88g2L1nTYXBdy5af4oHAMMhJrzY2Tsy
         mOcBSxivgiT3bHXFptS1WJYyXVNBYdUVKyHX6o7j01c29uHFMBLrgR7I3NawTEBe9cGf
         ld7G9gIiDeHKwyBfXLYjf1R1vtEmQAnNApN+Q6e4Xkw0Ry6rlCURtsUPVpKg0H5HQzd3
         t54nguyvfDanu28eXDiOO/HUgl0ioOJ1f2tMQb0i4rS3yJnsgdk7+BwCY5SjDoXfaxE1
         2Z8g==
X-Gm-Message-State: AOJu0YyeqbJ6MqjBJoIJlj5Erh+flvW4J/WPUbqCQcCvBQsZVaPtN7TS
        88lIvjaAi8Mc/8e9PkVispM=
X-Google-Smtp-Source: AGHT+IGsS0ybABVU0gSlvh634b7lSev/pAic38BOQT0jBO2o4HznWacSqgb/YE8IgpbdE5p0M3B43g==
X-Received: by 2002:a05:6000:18c9:b0:319:62e0:f2fe with SMTP id w9-20020a05600018c900b0031962e0f2femr9647539wrq.36.1696251649490;
        Mon, 02 Oct 2023 06:00:49 -0700 (PDT)
Received: from yoga ([2001:638:904:ffe5:5742:c50f:bd0:6aa6])
        by smtp.gmail.com with ESMTPSA id e9-20020adfe7c9000000b003197efd1e7bsm14065942wrn.114.2023.10.02.06.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 06:00:49 -0700 (PDT)
Date:   Mon, 02 Oct 2023 15:00:42 +0200
From:   Sven Frotscher <sven.frotscher@gmail.com>
Subject: Re: [PATCH v4] ASoC: amd: yc: Fix non-functional mic on Lenovo 82YM
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        mario.limonciello@amd.com, git@augustwikerfors.se,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>
Message-Id: <65KW1S.A6C8VBV29YCM@gmail.com>
In-Reply-To: <64c78944-4d62-4eda-b92b-3b415fea3333@sirena.org.uk>
References: <20230927223758.18870-1-sven.frotscher@gmail.com>
        <46560887-0b6e-42ac-96c3-b4dbc1d7cb61@leemhuis.info>
        <4fa7d39d-dc34-4550-97fa-2b089f364cca@sirena.org.uk>
        <541ac45b-8de7-4fa2-85ee-456d34e60aa9@leemhuis.info>
        <64c78944-4d62-4eda-b92b-3b415fea3333@sirena.org.uk>
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

Am Mo, 2. Okt 2023 um 13:54:59 +01:00:00 schrieb Mark Brown 
<broonie@kernel.org>:
> Until someone tests or otherwise provides specific information on a
> given machine we're just guessing about how it's wired up.

What specific information are we talking about here? I have the 82YM in 
front of me and could help investigate.


