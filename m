Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599EB78A0D7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 19:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjH0R6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 13:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjH0R5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 13:57:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F1CE67;
        Sun, 27 Aug 2023 10:57:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 232F860DD7;
        Sun, 27 Aug 2023 17:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D103C433C8;
        Sun, 27 Aug 2023 17:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693159033;
        bh=gstT0f0hupVwn5HbdOIKaJQZIOJRhkI6cNsrQCHQjv4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H9oT9OdmfIcvco23bTXTbyhZpafpk0UO9mthMMRZUqxIbUrwAS3KTizEjh0U0E54e
         sl9s15aji03ER4fECjhV1MvM7zvLVTcf9K9aYpgKWj0mlE8yLAn7WDJva5W/tpJySr
         3J3L6Tre9+A6FhrJCjnWykaGU822aKMSUODokPISTB+mVBKPkH2V+IKW+bnpg6avfE
         ohd142yakRLnJ8CQaLNvevFZ+AG5cVY/5Mxn7dA+ULfLfqilmjBj8K4xEGrLa/Xk5F
         UgQQlGSF/UBJFZ6skr9q9m4uj74MiiNkikq0zAeP5H4BgarDkWK+WAqriIfpLGZOA0
         5pTZwPYlKBaeA==
Date:   Sun, 27 Aug 2023 18:57:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mehdi Djait <mehdi.djait.k@gmail.com>, mazziesaccount@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 3/7] iio: accel: kionix-kx022a: Warn on failed
 matches and assume compatibility
Message-ID: <20230827185731.7f3b4725@jic23-huawei>
In-Reply-To: <ZOdEVYoWSUL3ZETy@smile.fi.intel.com>
References: <cover.1692824815.git.mehdi.djait.k@gmail.com>
        <2c69e918cb6dfab663bb62952c554b6b72f58390.1692824815.git.mehdi.djait.k@gmail.com>
        <ZOdEVYoWSUL3ZETy@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2023 14:51:49 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Aug 23, 2023 at 11:16:37PM +0200, Mehdi Djait wrote:
> > Avoid error returns on a failure to match and instead just warn with
> > assumption that we have a correct dt-binding telling us that
> > some new device with a different ID is backwards compatible.  
> 
> As we already discussed in the past I think this patch might be
> not okay in case a hardware vendor decides to make incompatible
> device with non-supported yet ID. It might be even harmful to
> the hardware to program register without knowing that this is safe.

That only matters if they 'claim' it is compatible. Otherwise the
driver never probes and we are fine.

DT maintainers view was that the job of the kernel was not to defend
against bugs in device tree firmwares or someone binding the driver
to the wrong device by hand.

> 
> That said, I'm neither NAKing nor reviewing this and leave to
> maintainers to decide.
> 

