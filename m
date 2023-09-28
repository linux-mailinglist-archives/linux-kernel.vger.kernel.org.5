Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9257B7B1EB8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjI1Nlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbjI1Nle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:41:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BC219C;
        Thu, 28 Sep 2023 06:41:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA69FC433C8;
        Thu, 28 Sep 2023 13:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695908491;
        bh=rJxLo1ABDRJDSxy1BujIrMAZQ/znSO0a+HwmrquB1+U=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mav+ZW23Dj6p8y5GSitPt1RgAPgFnreDpKvaTT6jmn2sRET+o9tGZOq2vct+4wJ6p
         MCV8h6xcv3Y5m81H44uouJ6banZb+ZuA0Fl/yCI7xzrOSbD+kSjc3ZK0C4tE9KiDhF
         2SeONbWxfHiJwFLNbBj+jY9iCz+eIAT8Vxa7VD90pT997dMhU8rgpjFO7/wJx6nycQ
         OrqX2d9nItKFqSD4BRx1sKWnSRZjyd4NsX52kcB+6N0yyAXSlmmIaOe6xs5m4llaXl
         o8TjNhUw1SxgRvIvrv6NkpaG2Kq+rlIdBN8CRzEMzGeyc1F8usoGT0oIpB72QnFybG
         pIrof6A38DGHw==
From:   Lee Jones <lee@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Justin Stitt <justinstitt@google.com>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
In-Reply-To: <20230922-strncpy-drivers-leds-leds-lp3952-c-v1-1-4941d6f60ca4@google.com>
References: <20230922-strncpy-drivers-leds-leds-lp3952-c-v1-1-4941d6f60ca4@google.com>
Subject: Re: (subset) [PATCH] leds: lp3952: replace deprecated strncpy with
 strscpy
Message-Id: <169590849042.1603670.14283146758350554856.b4-ty@kernel.org>
Date:   Thu, 28 Sep 2023 14:41:30 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2023 15:27:17 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect `dest` to be NUL-terminated due to its use with dev_err.
> 
> lp3952_get_label()'s  dest argument is priv->leds[i].name:
> |    acpi_ret = lp3952_get_label(&priv->client->dev, led_name_hdl[i],
> |                                priv->leds[i].name);
> ... which is then assigned to:
> |    priv->leds[i].cdev.name = priv->leds[i].name;
> ... which is used with a format string
> |    dev_err(&priv->client->dev,
> |            "couldn't register LED %s\n",
> |            priv->leds[i].cdev.name);
> 
> [...]

Applied, thanks!

[1/1] leds: lp3952: replace deprecated strncpy with strscpy
      commit: 821d3ff4b4e2c689576a623348555114e3f2f1c2

--
Lee Jones [李琼斯]

