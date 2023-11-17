Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B967EF711
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 18:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346179AbjKQRiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 12:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346173AbjKQRiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 12:38:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C343E10E5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 09:38:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A95C433C9;
        Fri, 17 Nov 2023 17:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700242689;
        bh=EUDBFroF5TjmYX0MrqbQ4lm7E/YuA+W3eE3VkPGKcm4=;
        h=From:To:Cc:Subject:Date:From;
        b=mtKlfPUJjJanONH237bSO3hOyU3SFX6xd57lxI10FihF5J/Mibv8D4PbuIiO4F5iy
         d4WA6/sHLhtXtn85tmoz8qRflR9TgpG14tbbU/u2a+SMRM04OTf2y5kJnuo0mfTcaE
         gQEg3YiAE39DARcXgaIYF5Ia1GBGkJ168le7YTOy0vg6tGGvcbwVyn7HDnnam8h3LV
         zJcX6KP7XzZSux28CArPbMBqEOCUU/OawwwhIYsz5NMxZWpfI21s3i3LoJkBgHAJ2H
         AYbrHhzqOdeRqKQjNWy+AcyBPetP5rOABkVxIGI+Tc5v3faQwuhgO9stvbnF/Q9zUT
         9E3RhmkCzm4fA==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r42nF-0005Vo-0K;
        Fri, 17 Nov 2023 18:38:13 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/3] USB: dwc3: qcom: fix resource leaks on probe deferral
Date:   Fri, 17 Nov 2023 18:36:47 +0100
Message-ID: <20231117173650.21161-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reviewing the recently submitted series which reworks the dwc3 qcom
glue implementation [1], I noticed that the driver's tear down handling
is currently broken, something which can lead to memory leaks and
potentially use-after-free issues on probe deferral and on driver
unbind.

Let's get this sorted before reworking driver.

Note that the last patch has only been compile tested as I don't have
access to a sdm845 device.

Johan

[1] https://lore.kernel.org/lkml/20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com/


Johan Hovold (3):
  USB: dwc3: qcom: fix resource leaks on probe deferral
  USB: dwc3: qcom: fix software node leak on probe errors
  USB: dwc3: qcom: fix ACPI platform device leak

 drivers/usb/dwc3/dwc3-qcom.c | 57 +++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 14 deletions(-)

-- 
2.41.0

