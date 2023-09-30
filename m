Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F2D7B41A4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 17:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbjI3PcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 11:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbjI3PcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 11:32:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D8CBE;
        Sat, 30 Sep 2023 08:32:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD47C433C7;
        Sat, 30 Sep 2023 15:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696087931;
        bh=1Tn6ZLkwalGfv97HZj9CO43jfDNacYTdeg5rnK92038=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g3QjBNL5tanIYp5cGyuidY3IrcNPxXwHBnYSuDLs0VmGuQPsPtNLELqYoPyRSTziH
         YP7eRhHq3iH1ekeMw4y2fuMQ/5d9Q5Iu/1yiCsV2+B6rAsPwfeK5QLr5uepZfb6fLH
         UMTjFDZXyGTfBaPONyyGlZwWTRBHxBREmffl8K78Hy0WSgyTK5RdAAuQQfKX4M7s0G
         RKU+T6Zz0XcB0VlM4Sf72r3nF44GNHcret5Cuiin9syXUqUkdKjv5S3wMuyEbWTJCI
         PpyljX/E5iQEQtDtx+MObqSEPorMVWlTUvfnshlgtdC90l7VLcWmoEIy0gVYPVc3XX
         UKdHcvuSo3CIg==
Date:   Sat, 30 Sep 2023 16:32:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev,
        David Lechner <david@lechnology.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 22/27] staging: iio: resolver: ad2s1210: convert LOS
 threshold to event attr
Message-ID: <20230930163209.17ee0020@jic23-huawei>
In-Reply-To: <20230929-ad2s1210-mainline-v3-22-fa4364281745@baylibre.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
        <20230929-ad2s1210-mainline-v3-22-fa4364281745@baylibre.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2023 12:23:27 -0500
David Lechner <dlechner@baylibre.com> wrote:

> From: David Lechner <david@lechnology.com>
> 
> From: David Lechner <dlechner@baylibre.com>
> 
> The AD2S1210 has a programmable threshold for the loss of signal (LOS)
> fault. This fault is triggered when either the sine or cosine input
> falls below the threshold voltage.
> 
> This patch converts the custom device LOS threshold attribute to an
> event falling edge threshold attribute on a new monitor signal channel.
> The monitor signal is an internal signal that combines the amplitudes
> of the sine and cosine inputs as well as the current angle and position
> output. This signal is used to detect faults in the input signals.
> 
> The attribute now uses millivolts instead of the raw register value in
> accordance with the IIO ABI.
> 
> Emitting the event will be implemented in a later patch.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

I think I'm fine with treating these internal signals like this, but
I would ideally like someone from Analog devices to take a look at how
these are being done and make sure our interpretations of the signals
make sense to them.  We are pushing the boundaries a little here (though
we have done similar before for fault events I think.)

Jonathan

