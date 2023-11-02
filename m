Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4B07DF50A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbjKBOaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235433AbjKBO3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:29:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39A4199
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 07:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698935344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tgr6D1BZg4DELT6k9Jshl8Q647baCv/R63fV2D1EpT4=;
        b=dnnoMBoNYJu7R/vXqMWYAdpCne64rHek2bxAFU28futZudzeAx1PecEOAS73s8m9vri7O9
        GQzducn8fafyUSSRuSyeo0/k6rmo8qO0c6YpQgTwGAt0ulwy8pB1gLh3nP1XrggHawS9En
        QUbON4eFff9KiyqP9MyF9yM+Lc1Geh4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-gx9XawOnM12EcVugmpxikA-1; Thu, 02 Nov 2023 10:28:57 -0400
X-MC-Unique: gx9XawOnM12EcVugmpxikA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9a681c3470fso76949266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 07:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698935336; x=1699540136;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tgr6D1BZg4DELT6k9Jshl8Q647baCv/R63fV2D1EpT4=;
        b=CLEcAIqZgXa9jwhWjUu4H2IB3a5hfmOGLfbC9kCHHPGJpB8GJ10B6krizgQYo0veHq
         FGSkbFfkciG0w+y3aasE/YLa9E/GgAy4cCLfQz00uItamZnBHzq8Edz1PX/i8HkKm7gy
         Vx4LrFoYMtn9k4gfGZxbQJaltx+ErKg1Yfe7P3L9BLblnnkgmnLx3Y0C+F4mi5nyuDXy
         y8Z0GmHZsYb9TXJV3cEL9k7oRiwH6HJnpUZPJxRqc3NBrPjr0E9fTc9kkR+xj4pGnSPh
         hV7WMJmo821ybxT4taSCedJCt32aXOFebfJhiVt2oexEbd/Z/v9rzGDSbXkaL93w7wOo
         hu2w==
X-Gm-Message-State: AOJu0YyvqXT5iRqjrXNE1CHLhY+86dbLH59FmXepaf1BpfmGSrvUbpA8
        lCZJcHpfmKnzjcqaIiWYZOM/0HXiid7/J6zxAQ2Ptz03Jp84uBblEv7dqT8pqUia6DJ0v5slYh8
        0IaF0k1gUIB/fH/3JjSqOBb1f
X-Received: by 2002:a17:906:794d:b0:9be:705:d7d0 with SMTP id l13-20020a170906794d00b009be0705d7d0mr4485993ejo.0.1698935336596;
        Thu, 02 Nov 2023 07:28:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4poVnLD0XD4/8r1MWwKjmLqh7ADhGy8kgs7Bz66kuVWfNYXAxB6/spjZ4Z0qzzGabzY5zwg==
X-Received: by 2002:a17:906:794d:b0:9be:705:d7d0 with SMTP id l13-20020a170906794d00b009be0705d7d0mr4485981ejo.0.1698935336251;
        Thu, 02 Nov 2023 07:28:56 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id lh23-20020a170906f8d700b009adc5802d08sm1201944ejb.190.2023.11.02.07.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 07:28:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------GnluoRzsnuYax0s2uyTESTIh"
Message-ID: <f9a5fda5-30db-f805-f079-a53a9c0218ce@redhat.com>
Date:   Thu, 2 Nov 2023 15:28:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 6/7] drm/i915/dsi: Replace poking of CHV GPIOs behind
 the driver's back
Content-Language: en-US, nl
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
References: <20231024155739.3861342-1-andriy.shevchenko@linux.intel.com>
 <20231024155739.3861342-7-andriy.shevchenko@linux.intel.com>
 <ZTfssxRsrDxhzSQ6@smile.fi.intel.com>
 <b489675d-e9de-4bca-9622-78545aa8606d@redhat.com>
 <16e533e2-81bb-47ba-9e23-460a626bcad7@redhat.com>
 <ZUIbPtEEbl6pjdqg@smile.fi.intel.com>
 <f68dca47-d9ed-a146-b152-c19bcc9d8828@redhat.com>
 <ZUOwAn158pUELTBq@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZUOwAn158pUELTBq@smile.fi.intel.com>
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------GnluoRzsnuYax0s2uyTESTIh
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11/2/23 15:19, Andy Shevchenko wrote:
> On Wed, Nov 01, 2023 at 11:20:23AM +0100, Hans de Goede wrote:
>> On 11/1/23 10:32, Andy Shevchenko wrote:
>>> On Tue, Oct 31, 2023 at 10:15:52PM +0100, Hans de Goede wrote:
>>>> On 10/31/23 17:07, Hans de Goede wrote:
>>>>> On 10/24/23 18:11, Andy Shevchenko wrote:
>>>>>> On Tue, Oct 24, 2023 at 06:57:38PM +0300, Andy Shevchenko wrote:
> 
> ...
> 
>> Note you still need the first part of my patch which is
>> an unrelated bugfix:
>>
>> --- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
>> +++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
>> @@ -219,8 +219,7 @@ static void soc_exec_gpio(struct intel_connector *connector, const char *con_id,
>>  	} else {
>>  		gpio_desc = devm_gpiod_get_index(dev_priv->drm.dev,
>>  						 con_id, gpio_index,
>> -						 value ? GPIOD_OUT_LOW :
>> -						 GPIOD_OUT_HIGH);
>> +						 value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW);
>>  		if (IS_ERR(gpio_desc)) {
>>  			drm_err(&dev_priv->drm,
>>  				"GPIO index %u request failed (%pe)\n",
> 
> Can you attach or send a formal submission, so I can incorporate it into one
> (v3) series among other changes?

I thought this fixed new code in your series and it is a trivial fix,
so my idea was that you would just fold the fix into the patch
introducing the code.

But I see now that this is existing code from bxt_exec_gpio().

A formal fix to use as a prep patch for your series is now attached,
this is based on top of drm-misc-next (I guess drm-intel-next
would be better but I had an up2date drm-misc-next handy).

Regards,

Hans


--------------GnluoRzsnuYax0s2uyTESTIh
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-drm-i915-dsi-Fix-wrong-initial-value-for-GPIOs-in-bx.patch"
Content-Disposition: attachment;
 filename*0="0001-drm-i915-dsi-Fix-wrong-initial-value-for-GPIOs-in-bx.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBjMzAwZWQwZTA5ZDFmZDE0YmY5NjZkYzE3MmM2ZGI1NGI4ODhmYWYzIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQu
Y29tPgpEYXRlOiBXZWQsIDEgTm92IDIwMjMgMTE6NDk6MDEgKzAxMDAKU3ViamVjdDogW1BB
VENIXSBkcm0vaTkxNS9kc2k6IEZpeCB3cm9uZyBpbml0aWFsIHZhbHVlIGZvciBHUElPcyBp
bgogYnh0X2V4ZWNfZ3BpbygpCgpGaXggd3JvbmcgaW5pdGlhbCB2YWx1ZSBmb3IgR1BJT3Mg
aW4gYnh0X2V4ZWNfZ3BpbygpLgoKU2lnbmVkLW9mZi1ieTogSGFucyBkZSBHb2VkZSA8aGRl
Z29lZGVAcmVkaGF0LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2lu
dGVsX2RzaV92YnQuYyB8IDQgKy0tLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rp
c3BsYXkvaW50ZWxfZHNpX3ZidC5jIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9p
bnRlbF9kc2lfdmJ0LmMKaW5kZXggZTU2ZWMzZjJkODRhLi4wNTg3Y2JjMmU1ODQgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfZHNpX3ZidC5jCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfZHNpX3ZidC5jCkBAIC0z
NTYsOSArMzU2LDcgQEAgc3RhdGljIHZvaWQgYnh0X2V4ZWNfZ3BpbyhzdHJ1Y3QgaW50ZWxf
Y29ubmVjdG9yICpjb25uZWN0b3IsCiAJaWYgKCFncGlvX2Rlc2MpIHsKIAkJZ3Bpb19kZXNj
ID0gZGV2bV9ncGlvZF9nZXRfaW5kZXgoZGV2X3ByaXYtPmRybS5kZXYsCiAJCQkJCQkgTlVM
TCwgZ3Bpb19pbmRleCwKLQkJCQkJCSB2YWx1ZSA/IEdQSU9EX09VVF9MT1cgOgotCQkJCQkJ
IEdQSU9EX09VVF9ISUdIKTsKLQorCQkJCQkJIHZhbHVlID8gR1BJT0RfT1VUX0hJR0ggOiBH
UElPRF9PVVRfTE9XKTsKIAkJaWYgKElTX0VSUl9PUl9OVUxMKGdwaW9fZGVzYykpIHsKIAkJ
CWRybV9lcnIoJmRldl9wcml2LT5kcm0sCiAJCQkJIkdQSU8gaW5kZXggJXUgcmVxdWVzdCBm
YWlsZWQgKCVsZClcbiIsCi0tIAoyLjQxLjAKCg==

--------------GnluoRzsnuYax0s2uyTESTIh--

