Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F898787BD0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 01:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241818AbjHXXJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 19:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243989AbjHXXIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 19:08:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8791BD8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 16:08:46 -0700 (PDT)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B09B166071DE;
        Fri, 25 Aug 2023 00:08:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692918524;
        bh=nisYa2aI8MTBzLiQ2v+r2NJegk+yL4MVy1zlu23bxBw=;
        h=Date:From:To:Cc:Subject:From;
        b=ckU6NWS72BQZ0knVc2FAmK/mE4mFjYYd8hc0QsPRcm/dr1X8UJAfmawNPq66vmSG+
         QjCvvhylE7w9cTRv6yeVINzb5B1SW84nPQAGkA4iHq5FawFbcW1hoGvQqDe9RfXf8m
         L9AoTeDvDEjLtj2gDR/ZFZfUgYnwdv0Kc3hXHzxqBwmiVdVgJ74zu7dQcrH371yY8M
         7HwZ6gO6PZrNHo19lHWzGXo/bh4bqr1CGbsnmFJ3LqcjzgdA55Wkvh+FsmYwiYqqqc
         UFs55d81JvtcdtcQwNjYIsUFtW+jjFqTaW2zxPBhDYAjcdcflt9/nhuhhPQxndVfeq
         orekVRNgo0+Lg==
Date:   Thu, 24 Aug 2023 19:08:39 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Stability guarantees on uevent variables?
Message-ID: <c0d32695-9e3e-4173-8448-7d123f38824e@notapiano>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

my question boils down to the following:

Is there a stability guarantee on the format and content of the variables in
uevents produced by the kernel?

I would assume so, given that uevents are explicitly produced for userspace, and
users will rely on them. However, looking through the ABI documentation I could
only find two instances of uevents being defined (testing/usb-uevent and
testing/usb-charger-uevent) and neither mention the variables added in the
KOBJ_ADD action. The document for the uevent file in sysfs,
testing/sysfs-uevent, only mentions writing synthetic uevents, rather than
reading existing ones. Is the documentation simply lacking or is it intentional
that uevent variables aren't covered?

I'm particularly interested in the format for the MODALIAS uevent variable. My
understanding is that its only use is to match against the modules' aliases in
the modules.alias file. For that reason I'm wondering whether for this variable,
the guarantee would only be that the format of the value will match the one in
modules.alias, but the precise format is not guaranteed (for example, a new
field could potentially be introduced in the future if added to both the device
uevent and module's alias). However, I do see a few ABI documentation pages for
the modalias file in sysfs (eg in testing/sysfs-bus-pci), which explicitly
describe the format, and that's supposed to be the same as the MODALIAS uevent,
so does that mean the format itself is stable?

I'll be happy to improve the ABI documentation based on the reply to these
questions.

As for the full context for these questions, as part of an effort to improve the
detection of regressions affecting device probe, I want to be able to check
whether devices under a discoverable bus (USB, PCI) were populated and probed by
a driver. We currently do this by checking against driver and device names [1],
but as has been pointed out before, that's not stable ABI, and the test might
break if things get renamed or moved around. So my intention is to change that
check to use modaliases or other uevents to find the device in a stable way and
check for the driver symlink to verify it's been probed.

[1] https://github.com/kernelci/bootrr/blob/3ae9fd5dffc667fa96012892ea08532bc6877276/boards/google%2Cspherion#L279

Thanks,
Nícolas
