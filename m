Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F13D7EC88F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjKOQ3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjKOQ3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:29:04 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EB0E6;
        Wed, 15 Nov 2023 08:29:01 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-7781b176131so367239585a.1;
        Wed, 15 Nov 2023 08:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700065740; x=1700670540; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qx3vpjTb9V9uPnz9xtV/2168OTukcHSXztsVSOdsyO0=;
        b=VlZd5o+LjeCp8ta8ah8fxWow8Zry7xnqCfAcYu7GkUypmoMP/1VzJ+tYPkj5d2X5ra
         qLh+ZV1SUOTnQ3YCRyUMHXuJekYIWrpp3n7HuOy5A9T73K2YxGlRl9mKMXJbULZ+XHv1
         mfwrcBBRaR5d7LoN+6yUWl+md49LF3lY2e7kj+TqLS0igdkB3sHeqITrbPLwBpAJotoA
         k+arGp3ENjWBFzVycke9P+z89646WRGcdw+aD3gRE8oKuHlPhuJFoGBBetK0Kol9S3Bi
         s4p0M0nIEd3QPOIgLW+9Uie6Yl1NYSebQFwWbIDWgpMTzs7c0wUYgcw7l+hA9EZU1eNe
         iQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700065740; x=1700670540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qx3vpjTb9V9uPnz9xtV/2168OTukcHSXztsVSOdsyO0=;
        b=TeY7IyN08jenKfTsO151sQV2dTW+JxLLqNbN2s3eSVgBmWmgqxY62Y0PXff5Lpzf2+
         AsOTtHpCnQ5TJHtkRUdiOdGs3aTULZ2KujrhRrLP4QfPwdn2BdibQ21jMcahrphAIVJL
         F3jCu2bjlGhuFlSR5q/SPSChbxkZyZFva6YI26E1feGGxBfCyNgwM4DeNxvtPk+WN5XH
         soBUCKiCAjP8LkTpipMjrsom4N+R4eOGJ128HuR694Hzk4s8NHIHWCjkNe+xtQTJARU6
         2XY6qiKwRRDJHjQYF9KFDfBKt/55Km5MIzaOsI//BGX2HovQdRKOrW8i4FVisMhVl0gb
         Y08Q==
X-Gm-Message-State: AOJu0Yw4GyiHUdZCCu7p0IhYey4B7XJqnMA4odXPzhGMiw7Hv1EkNf/J
        dIA+C5DvDWyhES+deXUH00U=
X-Google-Smtp-Source: AGHT+IF5NKClhj+lvUnav8OhyXMsa/XqFEZyXxK2HRXBTeJq9vJesW4uPM1z3QXPUZ+PqbfFyQPXLQ==
X-Received: by 2002:a05:620a:24ca:b0:776:f5bb:f2fc with SMTP id m10-20020a05620a24ca00b00776f5bbf2fcmr7066286qkn.9.1700065740456;
        Wed, 15 Nov 2023 08:29:00 -0800 (PST)
Received: from google.com ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id x3-20020a05620a0b4300b0076cda7eab11sm3550801qkg.133.2023.11.15.08.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 08:28:59 -0800 (PST)
Date:   Wed, 15 Nov 2023 16:28:54 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-spi@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v1 1/1] treewide, spi: Get rid of SPI_MASTER_HALF_DUPLEX
Message-ID: <ZVTxxrBgR708zC03@google.com>
References: <20231113111249.3982461-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113111249.3982461-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 01:12:49PM +0200, Andy Shevchenko wrote:
> The SPI_MASTER_HALF_DUPLEX is the legacy name of a definition
> for a half duplex flag. Since all others had been replaced with
> the respective SPI_CONTROLLER prefix get rid of the last one
> as well. There is no functional change intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com> # for input

Thanks.

-- 
Dmitry
