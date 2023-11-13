Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201CA7EA057
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjKMPmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjKMPmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:42:50 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709A6C2;
        Mon, 13 Nov 2023 07:42:46 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53b32dca0bfso9324636a12.0;
        Mon, 13 Nov 2023 07:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1699890165; x=1700494965; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5GrY9rf9c3EkAPZbYUhf5vMwJU3x6YJGgC6/sOVotWU=;
        b=bPLELnPWt5XPeLrFUQ5WUGfC7o6c1IpwiedkE3osVBErZpPV8c+o7n8Q4i87qvHjmQ
         rs9nozzYTzBz0L0lEczTc08l9K/PCNb4NbQn8SZXgbr5QyrR9hJReo/xxibFWfATfBu+
         naob+K/KK2ESE7HNUwxRAY4gL/aE5+KpB144IUPJNHnYgXhFwRqfw9IRRfvWHGcUYh6D
         PrGZ0SDg3kkOYsxBkmkUHmoBM8+ZFNzbfOdmuw4ClZxj+P+pz/oEjYB1D/Hh3pHizupX
         I3F0tdRexW9ICGESC0EepNavM8KuqwDkK9MBYFtx9IxK/3+Zkva4mOeRJyhCJ7XflzuW
         a8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699890165; x=1700494965;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5GrY9rf9c3EkAPZbYUhf5vMwJU3x6YJGgC6/sOVotWU=;
        b=BpOO+p1P0iDilD/VLd9b+Q2E2UDdmg5mkuSn6V4bPsJDGlm2hckP+1WzxsadcNjl66
         xI0nvDE9pWBd3dqQerN1aQQoPC4GWXlLFu0BhK5IfRgCyRElZGUn5CYKQexpeeQUcaNR
         EFCMCW0bkTEGSJm7Cyr+c3Z0LvzmXzbb7eyS8egRrErtWujkDc6JXljn6NZIpxFu9Hfb
         /NAu1TXNGPWoCCb316M57gd4+C+TXBTe2L0wBsWSXKA/DeznKBXUC9BB76BIVsrt0oA+
         XJhsAVdAtkZ8+xW/4E6XLgtUiRVrRFKVQ5VlUGzRs/QTG0R4nT+7zqA0MBNtn6v+7sYp
         Ya/Q==
X-Gm-Message-State: AOJu0YyidMxaqbUJApgtWuK7abG9QWeiQLX7ES0lMg+RhEvstnhJDSOL
        3mOjiGYfyHeceHvkS/hdtfbjUDsQBZHJoV2tq9k=
X-Google-Smtp-Source: AGHT+IFRsKUQ/netCmWEo4TA/rGA6MIVesCnPFmryCMcrOVoD6TVuetWV9FygDL8oYPe0zVqh28XTfpRolLPGGqadyg=
X-Received: by 2002:aa7:d686:0:b0:542:e5b1:8762 with SMTP id
 d6-20020aa7d686000000b00542e5b18762mr6407164edr.11.1699890164583; Mon, 13 Nov
 2023 07:42:44 -0800 (PST)
MIME-Version: 1.0
From:   James Hutchinson <jahutchinson99@googlemail.com>
Date:   Mon, 13 Nov 2023 15:42:33 +0000
Message-ID: <CAD+OKUp=MA6VahvoM0cXgrM1uSwGtqaTV80-+x2VBLgN1RPzag@mail.gmail.com>
Subject: platform/x86/intel/pmc: regression found in commit 804951203aa541ad6720c9726c173d18aeb3ab6b
To:     xi.pardee@intel.com, rajneesh bhardwaj <irenic.rajneesh@gmail.com>,
        david.e.box@intel.com, ilpo.jarvinen@linux.intel.com,
        hdegoede@redhat.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running here on an Intel NUC 8i3BEH Coffee Lake machine under Arch Linux.

Connected to this machine I have 4x USB DVB Cards (2xDVBSky S960
DVB-S2 adapters & 2xGeniatech T230 DVB-T2 adapters), and I stream TV
Channels around the house via Tvheadend.

Since linux kernel v6.5 onwards I noticed a bad performance regression
whereby the streams are basically unstable. There are tons of
continuity errors in the Tvheadend logfile, and the picture and sound
are badly broken up as though the system is throttled or does not have
the bandwidth to cope with the streams.

Sometimes the stream will work for a minute or so after reboot, before
then becoming unstable, and then seems to remain unstable until the
next cold reboot.

I dropped back to v6.1 LTS (where everything is fine) and re-tested
following the release of v6.6...
...the problem had not gone away so I performed a git bisect to
identify the culprit and found this to be:

804951203aa541ad6720c9726c173d18aeb3ab6b: platform/x86:intel/pmc:
Combine core_init() and core_configure()

I can work around the issue by either reverting this commit or by
disabling CONFIG_INTEL_PMC_CORE and rebuilding the kernel manually,
either of which results in perfect DVB streaming once more.

Happy to test any potential patches or otherwise provide further
information as required.


James.
