Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3D775D7F3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 01:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjGUXxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 19:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGUXxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 19:53:53 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4E930E1;
        Fri, 21 Jul 2023 16:53:52 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6686c74183cso2171459b3a.1;
        Fri, 21 Jul 2023 16:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689983632; x=1690588432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GaufzkzTdbkEtghya4t6kc4yJ+HLUq9RLfLwNt/UYbo=;
        b=WGw4AWsBk4Gpb7esrzVP6Gy5AEACeGv0QfkP8vVz7sOYQ+2/GzldfDXjSr+ux5i5CD
         o5kVxzXp88ar1SZxFPBVd0uMMHyiZ8huRrZh5Se8X2Gw+aCl+Pme6laPPAqTv8TNpuhI
         Od626zkWSYb/YvEimLBb4ddN/4qG8xTI49XmQrrM5aAFE2n0ymR/Qkim1acId5HifNso
         IoFO2/dY8DVJK7T96SCj/OKmTfMa+x8llRc5rzHF4v3UsuPowzs3H1SYr52XEbQ9+k7j
         6VhyM3HPlioXitk1OiC/xfyqRuLz45ut9fSIEkXSszRbxPKQj7ixE2G1McjysBPv19PD
         l0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689983632; x=1690588432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaufzkzTdbkEtghya4t6kc4yJ+HLUq9RLfLwNt/UYbo=;
        b=kYtbUfsUWQP5FPM0diTaNSnocpMJ9ZOrEi/FAnJbohKDqhbUKh6Oj1GeU99w5Ew0ea
         eNBHp3EnCW6X+pAg9w7ooh94VU3bxheFwe36socBv/W2AxVQsIKYCW6B0H5A7eIRb6f2
         dqGAxlrJS3OPNEvJKMfqkLdBzimI5VBBxrrSh/MVIMtB0sC4VVt8uxEK7AFYADeuwbKU
         FUW3mWDrwrzT+Q7aIPp9MAlGI+z8vO2MwyAhFDns68Fn+s2hdbHC3+jCmmjxtGOxKHyr
         YWXtUMN4rzo5lu+29IdvtIKfoerYMWwE504gTFOtStUHoHs4k9gIVzWs2I6i2uJiAyJd
         7PAQ==
X-Gm-Message-State: ABy/qLYCGsF4UJco5oNNDo8mTvhmq3FnU61qedMkry6/g+8Hww+OGsS7
        ax5cjhQZf4ocrvxaVKNKOTU=
X-Google-Smtp-Source: APBJJlFkHFbBlnt4VahY3XLY6U7B1209qdTV1AYbK3VLCvmJHosmPTLvCZthfL691geS+3nsmhL7UA==
X-Received: by 2002:a05:6a00:1988:b0:666:e42c:d5fb with SMTP id d8-20020a056a00198800b00666e42cd5fbmr1742204pfl.32.1689983632245;
        Fri, 21 Jul 2023 16:53:52 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:fd88:dbb:fc42:8207])
        by smtp.gmail.com with ESMTPSA id e5-20020aa78245000000b0064928cb5f03sm3494093pfn.69.2023.07.21.16.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 16:53:51 -0700 (PDT)
Date:   Fri, 21 Jul 2023 16:53:48 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jeffery Miller <jefferymiller@google.com>
Cc:     Jonathan Denose <jdenose@chromium.org>, jdenose@google.com,
        Lyude Paul <lyude@redhat.com>, benjamin.tissoires@redhat.com,
        Andrew Duggan <andrew@duggan.us>, loic.poulain@linaro.org,
        Andrew Duggan <aduggan@synaptics.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Input: synaptics-rmi4 - retry reading SMBus version
 on resume
Message-ID: <ZLsajIm2qTcLE+O7@google.com>
References: <20230608210404.722123-1-jefferymiller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608210404.722123-1-jefferymiller@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeffery,

On Thu, Jun 08, 2023 at 09:04:00PM +0000, Jeffery Miller wrote:
> On resume there can be a period of time after the
> preceding serio_resume -> psmouse_deactivate call
> where calls to rmi_smb_get_version fail with
> -ENXIO.
> 
> The call path in rmi_smb_resume is rmi_smb_resume -> rmi_smb_reset ->
> rmi_smb_enable_smbus_mode -> rmi_smb_get_version where
> this failure would occur.
> 
> Add a 30ms delay and retry in the ENXIO case to ensure the following
> rmi_driver_resume calls in rmi_smbus_resume can succeed.
> 
> This behavior was seen on a Lenovo T440p machine that required
> a delay of approximately 7-12ms.
> 
> The 30ms delay was chosen based on the linux-input message:
> Link: https://lore.kernel.org/all/BYAPR03MB47572F2C65E52ED673238D41B2439@BYAPR03MB4757.namprd03.prod.outlook.com/

I do not quite like putting these retries in RMI code. I wonder if we
should not move the delay into psmouse_smbus_reconnect():

	if (smbdev->need_deactivate) {
		psmouse_deactivate(psmouse);
		/* Give the device time to switch to SMBus mode */
		msleep(30);
	}

or even factor it out into psmouse_activate_smbus_mode() and call it
from psmouse_smbus_reconnect() as well as psmouse_smbus_init().

Thanks.

or even factor it out into psmouse_activate_smbus_mode() and call it
from psmouse_smbus_reconnect() as well as psmouse_smbus_init().

Thanks.

-- 
Dmitry
