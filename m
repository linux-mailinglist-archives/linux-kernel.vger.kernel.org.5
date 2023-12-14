Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5548125C8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 04:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443067AbjLNDJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 22:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjLNDJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 22:09:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C29DB0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 19:09:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CCFC433C8;
        Thu, 14 Dec 2023 03:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702523384;
        bh=xzN8VBpaQ+C7FVjwAk3uk6XkuZkz8OK0t7++aNp/cIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nC+RhMcTfI/6+5mFEnRMg0ZdIKa7dY0hlVas3wsZuOWL4dp4qkeELxPuR3z0z+M0w
         XnLvoKtUCNSQbw8YLXWwmvhJLa7eb5rHfU+VXUd9Q+kVtosQ3yhZDlmAdwV2T5nMVV
         6j0J2beZpq1bzBCSABWofyFdhI0wcbt/45kPk1Mdovuxj95c5YMMl/TswoWh/Pj89J
         42aJkUJBMovQJzuZYkaWMG4/BtPiTozdNRA+n2YOyF2irlRvEehsr4gKR4zatKEYrQ
         7DK91asMXsHWtdZSyOE6TwJZX53lZ1kPlpx3N5mcmtQvyd6N8QzPBuylQoPrVBPKgs
         Fnf129/eaGwwg==
Date:   Thu, 14 Dec 2023 11:09:41 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Mark Hasemeyer <markhas@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Raul Rangel <rrangel@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Rob Barnes <robbarnes@google.com>,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH v1 6/6] platform/chrome: cros_ec: Use PM subsystem to
 manage wakeirq
Message-ID: <ZXpx9esFooSgq11q@google.com>
References: <20231213110009.v1.1.Ifd0903f1c351e84376d71dbdadbd43931197f5ea@changeid>
 <20231213110009.v1.6.Ieee574a0e94fbaae01fd6883ffe2ceeb98d7df28@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213110009.v1.6.Ieee574a0e94fbaae01fd6883ffe2ceeb98d7df28@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 11:00:24AM -0700, Mark Hasemeyer wrote:
> The cros ec driver is manually managing the wake irq by calling
> enable_irq_wake/disable_irq_wake during suspend/resume.
> 
> Modify the driver to use the power management subsystem to manage the
> wakeirq.
> 
> The wake capability of the interrupt is provided by the underlying
> firmware/device tree. Some Chromebooks rely solely on the ec_sync pin to
> wake the AP but they do not specify the interrupt as wake capable in the
> ACPI _CRS or device tree. For LPC/ACPI based systems a DMI quirk is
> introduced listing boards whose firmware should not be trusted to
> provide correct wake capable values.
> 
> The irq wake logic was added on an interface basis (lpc, spi, uart) as
> opposed to adding it to cros_ec.c because the i2c subsystem already does
> this work on our behalf.

It looks to me the patch combines multiple changes.  Please separate them into
smaller pieces for reviewing easier.

Another confusing about the patch subject: "6/6"?  Is it a series?  I don't
see the cover letter.
