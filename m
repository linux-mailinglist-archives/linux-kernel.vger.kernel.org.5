Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CFC7802A5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 02:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356702AbjHRAQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 20:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356786AbjHRAQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 20:16:05 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D033FE;
        Thu, 17 Aug 2023 17:16:03 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso316946a12.1;
        Thu, 17 Aug 2023 17:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692317763; x=1692922563;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2dZC6I9263vVrfc1sUtjjkPmfW6/RSeek9PprIZRkEM=;
        b=lKELf2czkVnZlHfQA9i7vJNnNd5DC6dKqaKgqW+COsja4jbtVzN6FZICcKsO/YbIx+
         qJ2TZvjXUjdEUFTtpnEC2AlUCmyUEm527LdRXAY3IYSkmhmpl3E5XpajIvZ5+124JzOR
         q9TTd79Bg4vQhDiU+CVBvceMBQp5AtBYPk8Y7MOPVV/16HvU46hiYPSksEQ2v0UccD+/
         +Zi8+MZLIyb838yZ0fJWUBKe7lfiAV5PSZDVQX8PzbCJxDcHfrliaX9I9d9W4QvXwQUY
         sHdNuKOtGP6pX6Gl8fjSHqJHYSV+vlvGsKX1C6tvRsL3sVhQeS49OVc4CVV0BAdcP4eV
         Xdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692317763; x=1692922563;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2dZC6I9263vVrfc1sUtjjkPmfW6/RSeek9PprIZRkEM=;
        b=UJme/ldLq1xVwX5GPpM/DEur6vrJNy4LaFMiqCmsuLVAYfUVzOmN4OUbPUQsEn0uIE
         4gibQER7HvMFP7CkKvGmaokac0b1Gpw0kD5UHVRyAoeq+H2dOk6i3mKwNk1vJyKvnzRg
         N87QiTPFFqV1WCwCcUHWfz/Do/VmLWxrawuvKM6V88FhbxayxY7bcrcDOtgiIqkteOCj
         7gzgSmKGlWZZ7BaNYzRpchD3e1CFR2+nqYH57V/DYf42yTXMZqEQ9BUTWlNEAk66D8FH
         FIgvqSwzyEO+VS3+QXCpOejEt3q2m8PqvkeRN84CX5k78X6GlLtzpUsL4cIuW9/1ijFM
         Z2NQ==
X-Gm-Message-State: AOJu0Yxyg7d9osQ+znhXUV5QlOS+u9XCpEumXjxQAv2TtitL/I59jofh
        tKKWw/OHyo85KZXDhFnnBMvWPMwe15nluRnnWu0=
X-Google-Smtp-Source: AGHT+IGlFGWDpYqKetUPlFM7ih87U7uJrfuNsmPwe6MMJ3aFK5QnSp6xSXMhlZfeGV6t6Axn+3XYIy2J3cqAYS+M8hE=
X-Received: by 2002:a17:90a:bf02:b0:267:f1d0:ca70 with SMTP id
 c2-20020a17090abf0200b00267f1d0ca70mr992707pjs.47.1692317762928; Thu, 17 Aug
 2023 17:16:02 -0700 (PDT)
MIME-Version: 1.0
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Fri, 18 Aug 2023 02:15:52 +0200
Message-ID: <CA+fCnZcQSYy63ichdivAH5-fYvN2UMzTtZ--h=F6nK0jfVou3Q@mail.gmail.com>
Subject: dwc3: unusual handling of setup requests with wLength == 0
To:     Alan Stern <stern@rowland.harvard.edu>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan and Thinh,

I have been testing Raw Gadget with the dwc3 UDC driver and stumbled
upon an issue related to how dwc3 handles setup requests with wLength
== 0.

When running a simple Raw Gadget-based keyboard emulator [1],
everything works as expected until the point when the host sends a
SET_CONFIGURATION request, which has wLength == 0.

For setup requests with wLength != 0, just like the other UDC drivers
I tested, dwc3 calls the gadget driver's ->setup() callback and then
waits until the gadget driver queues an URB to EP0 as a response.

However, for a setup request with wLength == 0, dwc3 does not wait
until the gadget driver queues an URB to ack the transfer. It appears
that dwc3 just acks the request internally and then proceeds with
calling the ->setup() callback for the next request received from the
host. This confuses Raw Gadget, as it does not expect to get a new
->setup() call before it explicitly acks the previous one by queuing
an URB. As a result, the emulation fails.

I suspect this issue has not been observed with other gadget drivers,
as they queue an URB immediately after receiving a ->setup() call:
dwc3 appears to somehow correctly handle this internally even though
it acks the transfer by itself. But the timings with Raw Gadget are
different, as it requires userspace to ack the transfer. Sometimes
though, the Raw Gadget-based emulator also manages to queue an URB
before the next request is received from the host and the enumeration
continues properly (until the next request with wLength == 0).

What do you think would be the best approach to deal with this?

Can this be considered a bug in dwc3 that should be fixed? There's a
seemingly related comment in dwc3 code [2], but I'm not familiar
enough with its internals to understand whether this is what leads to
the issue I'm seeing.

Or should I adapt Raw Gadget to handle this unusual dwc3 behavior?
This might be tricky to do, as I cannot change the existing userspace
API.

On a side note, as an experiment, I tried returning
USB_GADGET_DELAYED_STATUS from the Raw Gadget's ->setup() callback if
the UDC driver calls it too early: some UDC drivers, including dwc3,
appear to contain a special handling for this return value. However,
that didn't work out. Perhaps, I misunderstand the meaning of this
value.

Thank you!

[1] https://github.com/xairy/raw-gadget/blob/master/examples/keyboard.c
[2] https://elixir.bootlin.com/linux/v6.5-rc6/source/drivers/usb/dwc3/ep0.c#L145
