Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55277B41B2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 17:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbjI3Pdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 11:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbjI3Pd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 11:33:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3334311F;
        Sat, 30 Sep 2023 08:33:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37246C433C7;
        Sat, 30 Sep 2023 15:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696087999;
        bh=eSAPVmpMsnO0oz6bOiAtbQ81h57LmzjT+oOEAB6nLUQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DxCpeIC+XOiE1L256j03FUSFj0ZTLejjqGL8lwHBFZIWyggmPVzV3wXXj/99TXLzh
         2wpsjVGC/VQYtnM/Vu/VLzUpdAfZJnOlQTr12lmpuqSChHGfW7N0Fg3/MgfnJ2CnEK
         NZkoZBTrNeXXHrUJsd42+XLRsMUYe8sYoiWkN3E77Zq1WLIoTYxslAocDrhOq5coai
         /Fn8tv6DLeoyhXiqJQp6uv5ggn81wh3OgLqgmNtyxJXpCLIJhJ9bzzrOXOYnAveoyp
         qM8ja44USZeWqXyLboesglUgFtmBKxfYrsj/goUeGhlOdjLsSm/PR66Hc31QkVMcj0
         wdPHd4ErQ3Z5w==
Date:   Sat, 30 Sep 2023 16:33:18 +0100
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
Subject: Re: [PATCH v3 23/27] staging: iio: resolver: ad2s1210: convert DOS
 overrange threshold to event attr
Message-ID: <20230930163318.7b9d6181@jic23-huawei>
In-Reply-To: <20230929-ad2s1210-mainline-v3-23-fa4364281745@baylibre.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
        <20230929-ad2s1210-mainline-v3-23-fa4364281745@baylibre.com>
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

On Fri, 29 Sep 2023 12:23:28 -0500
David Lechner <dlechner@baylibre.com> wrote:

> From: David Lechner <david@lechnology.com>
> 
> From: David Lechner <dlechner@baylibre.com>
> 
> The AD2S1210 has a programmable threshold for the degradation of signal
> (DOS) overrange fault. This fault is triggered when either the sine or
> cosine input rises the threshold voltage.

rises above the threshold voltage.

> 
> This patch converts the custom device DOS overrange threshold attribute
> to an event rising edge threshold attribute on the monitor signal
> channel.
> 
> The attribute now uses millivolts instead of the raw register value in
> accordance with the IIO ABI.
> 
> Emitting the event will be implemented in a later patch.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
