Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EC97D9C4C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346145AbjJ0O4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345845AbjJ0O4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:56:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90323128
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698418513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7GcgtRljqp8I6+SbcnMUmqHUR4tncRi9vmDfTIxBtlw=;
        b=XFEbk2vSTA6RPgiuF6r2OOnvLbh3HJZ9QATpk/COrp03skGQVBBs7D331YMiQ3qOVQwSOa
        uu0xZ7KjucqYVguy+b4Rb1XWcerZPFprmeGCyElTfZH/wbBbZY6C2fDoD8UbryW5pGfCmr
        LLNzy5X+hW4Si/Pi9mYASbxvWF9kGkU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-vQcXeLj0MYGh4EIxsVp4OA-1; Fri, 27 Oct 2023 10:55:12 -0400
X-MC-Unique: vQcXeLj0MYGh4EIxsVp4OA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-538128e18e9so1615282a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:55:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698418511; x=1699023311;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7GcgtRljqp8I6+SbcnMUmqHUR4tncRi9vmDfTIxBtlw=;
        b=ZzRSu+nwGaQlyKe6S0sKQNqxulnliIdjiriecdhQN39BaWkz6y/SHVxZbV9zvBukHA
         pdAWiYjfYb3YgehRs3nk8IDdeyDMGPg5uAhLkK+T3xSTzX/+/XJxamZKyoODmnIrpCsI
         TZgoRTKAl/+MpfzWef0HjJmMv93KBvl2ZCh9DqXmpVzmBfh665X+9WiOD1rI5Z92bNRA
         NDIGc4EuJKJG3QnYFGW2+ydQfZmz+xf5M/n9E3WLd3DZ3hw/7U6utjq5eol3CMVyBWvF
         6H37zszygkowKDXAvt6r7R9cqDe0hDQVg5O2hlllLDHCVUuCQ4KpWo0Q51Tnf6PDv2Eg
         tXBg==
X-Gm-Message-State: AOJu0YzCTj8H1HOefYBKjD6ALS5ks454/1Hfx2+Vub/8JXNg0JKQpxlq
        03J2CGj0XtJh/rBFw/3/OoQp9tgzcdPpkjb2QkWVgt5pLMpE6+B8DdJtsPty+NbwGBaEo9ul+6M
        qOZbCrJJnaniXr98Gn9nf3/e3
X-Received: by 2002:a17:907:7f8c:b0:9b8:b683:5854 with SMTP id qk12-20020a1709077f8c00b009b8b6835854mr3108904ejc.61.1698418510942;
        Fri, 27 Oct 2023 07:55:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBLB+7mAs+KwOKlv3cy3r8ss/FeYSMLZK3aFqu+TIHhymj+Pn9FNh4CszMk/hjBCRVHuAd9A==
X-Received: by 2002:a17:907:7f8c:b0:9b8:b683:5854 with SMTP id qk12-20020a1709077f8c00b009b8b6835854mr3108887ejc.61.1698418510654;
        Fri, 27 Oct 2023 07:55:10 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id u27-20020a1709063b9b00b0099bcb44493fsm1325920ejf.147.2023.10.27.07.55.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 07:55:10 -0700 (PDT)
Message-ID: <00ebd650-72c1-0901-27bc-ae18867ed4b4@redhat.com>
Date:   Fri, 27 Oct 2023 16:55:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.6-6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        David Lazar <dlazar@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Sorry for the somewhat last minute pull-request. This pull contains
a single patch to extend the AMD PMC driver DMI quirk list for laptops
which need special handling to avoid NVME s2idle suspend/resume errors.

The chance of this causing regressions should be close to 0 since it
just extends a list of DMI quirks.

I decided to send this in at the last minute because together with
"x86/i8259: Skip probing when ACPI/MADT advertises PCAT compatibility"
which is pending in tip x86/urgent this fixes a whole group of 9 Lenovo
AMD Mendocino Soc based laptop models from being unusable with Linux
to them working fine with Linux.

Regards,

Hans



The following changes since commit 99c09c985e5973c8f0ad976ebae069548dd86f12:

  platform/mellanox: mlxbf-tmfifo: Fix a warning message (2023-10-18 15:38:09 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.6-6

for you to fetch changes up to 3bde7ec13c971445faade32172cb0b4370b841d9:

  platform/x86: Add s2idle quirk for more Lenovo laptops (2023-10-27 16:42:12 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.6-6

A single patch to extend the AMD PMC driver DMI quirk list for laptops
which need special handling to avoid NVME s2idle suspend/resume errors.

----------------------------------------------------------------
David Lazar (1):
      platform/x86: Add s2idle quirk for more Lenovo laptops

 drivers/platform/x86/amd/pmc/pmc-quirks.c | 73 +++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

