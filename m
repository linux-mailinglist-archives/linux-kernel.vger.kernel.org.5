Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E7C7DE003
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 12:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbjKALCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 07:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjKALC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 07:02:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB448F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 04:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698836495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fy6tkWm0y2Nkm2fnSFyjz6gKBn3YQc+IQZWdr7dI69s=;
        b=RJ8YR59ZSgGnu+RJZ9svEaj7R3yEnl3cmQbZhztyDlg7TnWBgWqRpxvxK8+gr0bOZBNAH8
        MfqEtiEtTIU4fZv8/vQqVLPEt/sNA2vRhoSZkW8xuBGwxqK8ErLIxArOS/i4ofut63X/9G
        cKtbYUczqg33wu+dCkJXHTX1Q3vS/tY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-w6h2h1ylOBmlAqkGcSvbSQ-1; Wed, 01 Nov 2023 07:01:34 -0400
X-MC-Unique: w6h2h1ylOBmlAqkGcSvbSQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9c7558b89ccso423843666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 04:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698836493; x=1699441293;
        h=in-reply-to:references:cc:to:from:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fy6tkWm0y2Nkm2fnSFyjz6gKBn3YQc+IQZWdr7dI69s=;
        b=b7FMwz1Zmzsb/0fWpX48hCo5xm/YphRzEvfZV/Kcp586n6X1PJyYkUOBhy36Ivq7a5
         x82rwGT8s6wK9e0zGF8XuCqb7ouHJdlEJqXdYPu2qPBc1QmsDmlTP6Fu6lTmUkwD+QeG
         mi+z7GvWvmt1CA+S6es6tT1iDqhmajpTtCpBL09EqESxJ8xOadH2cweP2iNrIMynB0Wq
         MZb6/f0CCOihorp6YHJR1PdS5J/bLI8DpbOta2ieVxeOSQPuYcJLpN0IIE5T/RCKYrZr
         /mtaerevS+vhRXQZrdlKz5IEPn9W3gt/6Wuw4UtFRqIVCmYVABOK/GhYTtba/VhayFZ7
         oGKQ==
X-Gm-Message-State: AOJu0YwMx6ySMO3v6Sz4Y6XMdDSTgR46Nnd6D1xG0GULheXrNGBD3tEh
        5035U1//FzejiCw0zOVOKzXWE20CBEb35LkyfS0V0VYaT0StI6u/fk9J76mvKFSyzDEHWMkbkH8
        cMphSzt0KDbOGTg0f0Mrz93YX
X-Received: by 2002:a17:907:a05:b0:9d0:4b8f:3da3 with SMTP id bb5-20020a1709070a0500b009d04b8f3da3mr1451505ejc.30.1698836492989;
        Wed, 01 Nov 2023 04:01:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEl/nZcawUVb9gBJs5xh5/8zg6t/uv24ePaA8CiOaMsOmeN778WCQ+7btjVgAW+jf0CABRfew==
X-Received: by 2002:a17:907:a05:b0:9d0:4b8f:3da3 with SMTP id bb5-20020a1709070a0500b009d04b8f3da3mr1451486ejc.30.1698836492643;
        Wed, 01 Nov 2023 04:01:32 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id t17-20020a17090616d100b0099cb349d570sm2264480ejd.185.2023.11.01.04.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 04:01:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------ut2CYh1xth06y9kfNtp1tqdw"
Message-ID: <437a20fe-121e-0d8c-04a0-da30db71d2ea@redhat.com>
Date:   Wed, 1 Nov 2023 12:01:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 6/7] drm/i915/dsi: Replace poking of CHV GPIOs behind
 the driver's back
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
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
In-Reply-To: <f68dca47-d9ed-a146-b152-c19bcc9d8828@redhat.com>
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------ut2CYh1xth06y9kfNtp1tqdw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11/1/23 11:20, Hans de Goede wrote:
> Hi,
> 
> On 11/1/23 10:32, Andy Shevchenko wrote:
>> On Tue, Oct 31, 2023 at 10:15:52PM +0100, Hans de Goede wrote:
>>> On 10/31/23 17:07, Hans de Goede wrote:
>>>> On 10/24/23 18:11, Andy Shevchenko wrote:
>>>>> On Tue, Oct 24, 2023 at 06:57:38PM +0300, Andy Shevchenko wrote:
>>
>> ...
>>
>>>> As for the CHT support, I have not added that to my tree yet, I would
>>>> prefer to directly test the correct/fixed patch.
>>>
>>> And I hit the "jackpot" on the first device I tried and the code needed
>>> some fixing to actually work, so here is something to fold into v3 to
>>> fix things:
>>
>> Thanks!
>>
>> But let me first send current v3 as it quite differs to v2 in the sense
>> of how I do instantiate GPIO lookup tables.
> 
> The problem is there already is a GPIO lookup table registered for
> the "0000:00:02.0" device by intel_dsi_vbt_gpio_init() and there can
> be only be one GPIO lookup table per device. So no matter how you
> instantiate GPIO lookup tables it will not work.
> 
> The solution that I chose is to not instantiate a GPIO lookup table
> at all and instead to extend the existing table with an extra entry.
> 
> Although thinking more about it I must admit that this is racy.
> 
> So a better idea would be to unregister the GPIO lookup
> table registered by intel_dsi_vbt_gpio_init() after getting
> the GPIOs there, that would allow instantiating a new one
> from soc_exec_opaque_gpio() as it currently does and that
> would be race free.
> 
>> Meanwhile I will look into the change you sent (and hopefully we can
>> incorporate something in v3 for v4).
> 
> Ok, lets go with your v3.
> 
> I'll prepare a patch  to move the unregistering of the existing
> conflicting GPIO lookup from intel_dsi_vbt_gpio_cleanup()
> to the end of intel_dsi_vbt_gpio_init() to avoid the conflict
> we have there.

Attached is this patch, this should probably be one of
the first patches in the v3 submission.

Note that if you go with Ville's suggestion to preparse
the MIPI sequences, things will change significantly
and then the attached patch will likely be unnecessary.

Regards,

Hans




> Note you still need the first part of my patch which is
> an unrelated bugfix:
> 
> --- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
> +++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
> @@ -219,8 +219,7 @@ static void soc_exec_gpio(struct intel_connector *connector, const char *con_id,
>  	} else {
>  		gpio_desc = devm_gpiod_get_index(dev_priv->drm.dev,
>  						 con_id, gpio_index,
> -						 value ? GPIOD_OUT_LOW :
> -						 GPIOD_OUT_HIGH);
> +						 value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW);
>  		if (IS_ERR(gpio_desc)) {
>  			drm_err(&dev_priv->drm,
>  				"GPIO index %u request failed (%pe)\n",
> 
> Regards,
> 
> Hans
> 
> 

--------------ut2CYh1xth06y9kfNtp1tqdw
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-drm-i915-dsi-Remove-GPIO-lookup-table-at-the-end-of-.patch"
Content-Disposition: attachment;
 filename*0="0001-drm-i915-dsi-Remove-GPIO-lookup-table-at-the-end-of-.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBjYjNjYzY1NmFkODlkOTg4MjRkMzhjMDdhMzUwMTljNTEyMjI3NjAxIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQu
Y29tPgpEYXRlOiBXZWQsIDEgTm92IDIwMjMgMTE6NTQ6MTggKzAxMDAKU3ViamVjdDogW1BB
VENIXSBkcm0vaTkxNS9kc2k6IFJlbW92ZSBHUElPIGxvb2t1cCB0YWJsZSBhdCB0aGUgZW5k
IG9mCiBpbnRlbF9kc2lfdmJ0X2dwaW9faW5pdCgpCgpUbyBwcm9wZXJseSBkZWFsIHdpdGgg
R1BJT3MgdXNlZCBpbiBNSVBJIHBhbmVsIHNlcXVlbmNlcyBhIHRlbXBvcmFyeQpHUElPIGxv
b2t1cCB3aWxsIGJlIHVzZWQuIFNpbmNlIHRoZXJlIGNhbiBvbmx5IGJlIDEgR1BJTyBsb29r
dXAgdGFibGUKZm9yIHRoZSAiMDAwMDowMDowMi4wIiBkZXZpY2UgdGhpcyB3aWxsIG5vdCB3
b3JrIGlmIHRoZSBHUElPIGxvb2t1cAp0YWJsZSB1c2VkIGJ5IGludGVsX2RzaV92YnRfZ3Bp
b19pbml0KCkgaXMgc3RpbGwgcmVnaXN0ZXJlZC4KCkFmdGVyIGdldHRpbmcgdGhlICJiYWNr
bGlnaHQiIGFuZCAicGFuZWwiIEdQSU9zIHRoZSBsb29rdXAgdGFibGUKcmVnaXN0ZXJlZCBi
eSBpbnRlbF9kc2lfdmJ0X2dwaW9faW5pdCgpIGlzIG5vIGxvbmdlciBuZWNlc3NhcnksCnJl
bW92ZSBpdCBzbyB0aGF0IGFub3RoZXIgdGVtcG9yYXJ5IGxvb2t1cC10YWJsZSBmb3IgdGhl
ICIwMDAwOjAwOjAyLjAiCmRldmljZSBjYW4gYmUgYWRkZWQuCgpTaWduZWQtb2ZmLWJ5OiBI
YW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2Ry
bS9pOTE1L2Rpc3BsYXkvaW50ZWxfZHNpX3ZidC5jIHwgMjUgKysrKysrKy0tLS0tLS0tLS0t
LS0KIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfZHNpX3Zi
dC5jIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9kc2lfdmJ0LmMKaW5k
ZXggY2I2NDQ1NDkzMmQxLi5kOTY1YWUxZDJiMDggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfZHNpX3ZidC5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9pOTE1L2Rpc3BsYXkvaW50ZWxfZHNpX3ZidC5jCkBAIC05MjIsNiArOTIyLDcgQEAgdm9p
ZCBpbnRlbF9kc2lfdmJ0X2dwaW9faW5pdChzdHJ1Y3QgaW50ZWxfZHNpICppbnRlbF9kc2ks
IGJvb2wgcGFuZWxfaXNfb24pCiAJc3RydWN0IGludGVsX2Nvbm5lY3RvciAqY29ubmVjdG9y
ID0gaW50ZWxfZHNpLT5hdHRhY2hlZF9jb25uZWN0b3I7CiAJc3RydWN0IG1pcGlfY29uZmln
ICptaXBpX2NvbmZpZyA9IGNvbm5lY3Rvci0+cGFuZWwudmJ0LmRzaS5jb25maWc7CiAJZW51
bSBncGlvZF9mbGFncyBmbGFncyA9IHBhbmVsX2lzX29uID8gR1BJT0RfT1VUX0hJR0ggOiBH
UElPRF9PVVRfTE9XOworCXN0cnVjdCBncGlvZF9sb29rdXBfdGFibGUgKmdwaW9kX2xvb2t1
cF90YWJsZSA9IE5VTEw7CiAJYm9vbCB3YW50X2JhY2tsaWdodF9ncGlvID0gZmFsc2U7CiAJ
Ym9vbCB3YW50X3BhbmVsX2dwaW8gPSBmYWxzZTsKIAlzdHJ1Y3QgcGluY3RybCAqcGluY3Ry
bDsKQEAgLTkyOSwxMiArOTMwLDEyIEBAIHZvaWQgaW50ZWxfZHNpX3ZidF9ncGlvX2luaXQo
c3RydWN0IGludGVsX2RzaSAqaW50ZWxfZHNpLCBib29sIHBhbmVsX2lzX29uKQogCiAJaWYg
KChJU19WQUxMRVlWSUVXKGRldl9wcml2KSB8fCBJU19DSEVSUllWSUVXKGRldl9wcml2KSkg
JiYKIAkgICAgbWlwaV9jb25maWctPnB3bV9ibGMgPT0gUFBTX0JMQ19QTUlDKSB7Ci0JCWdw
aW9kX2FkZF9sb29rdXBfdGFibGUoJnBtaWNfcGFuZWxfZ3Bpb190YWJsZSk7CisJCWdwaW9k
X2xvb2t1cF90YWJsZSA9ICZwbWljX3BhbmVsX2dwaW9fdGFibGU7CiAJCXdhbnRfcGFuZWxf
Z3BpbyA9IHRydWU7CiAJfQogCiAJaWYgKElTX1ZBTExFWVZJRVcoZGV2X3ByaXYpICYmIG1p
cGlfY29uZmlnLT5wd21fYmxjID09IFBQU19CTENfU09DKSB7Ci0JCWdwaW9kX2FkZF9sb29r
dXBfdGFibGUoJnNvY19wYW5lbF9ncGlvX3RhYmxlKTsKKwkJZ3Bpb2RfbG9va3VwX3RhYmxl
ID0gJnNvY19wYW5lbF9ncGlvX3RhYmxlOwogCQl3YW50X3BhbmVsX2dwaW8gPSB0cnVlOwog
CQl3YW50X2JhY2tsaWdodF9ncGlvID0gdHJ1ZTsKIApAQCAtOTUxLDYgKzk1Miw5IEBAIHZv
aWQgaW50ZWxfZHNpX3ZidF9ncGlvX2luaXQoc3RydWN0IGludGVsX2RzaSAqaW50ZWxfZHNp
LCBib29sIHBhbmVsX2lzX29uKQogCQkJCSJGYWlsZWQgdG8gc2V0IHBpbm11eCB0byBQV01c
biIpOwogCX0KIAorCWlmIChncGlvZF9sb29rdXBfdGFibGUpCisJCWdwaW9kX2FkZF9sb29r
dXBfdGFibGUoZ3Bpb2RfbG9va3VwX3RhYmxlKTsKKwogCWlmICh3YW50X3BhbmVsX2dwaW8p
IHsKIAkJaW50ZWxfZHNpLT5ncGlvX3BhbmVsID0gZ3Bpb2RfZ2V0KGRldi0+ZGV2LCAicGFu
ZWwiLCBmbGFncyk7CiAJCWlmIChJU19FUlIoaW50ZWxfZHNpLT5ncGlvX3BhbmVsKSkgewpA
QCAtOTY5LDE1ICs5NzMsMTMgQEAgdm9pZCBpbnRlbF9kc2lfdmJ0X2dwaW9faW5pdChzdHJ1
Y3QgaW50ZWxfZHNpICppbnRlbF9kc2ksIGJvb2wgcGFuZWxfaXNfb24pCiAJCQlpbnRlbF9k
c2ktPmdwaW9fYmFja2xpZ2h0ID0gTlVMTDsKIAkJfQogCX0KKworCWlmIChncGlvZF9sb29r
dXBfdGFibGUpCisJCWdwaW9kX3JlbW92ZV9sb29rdXBfdGFibGUoZ3Bpb2RfbG9va3VwX3Rh
YmxlKTsKIH0KIAogdm9pZCBpbnRlbF9kc2lfdmJ0X2dwaW9fY2xlYW51cChzdHJ1Y3QgaW50
ZWxfZHNpICppbnRlbF9kc2kpCiB7Ci0Jc3RydWN0IGRybV9kZXZpY2UgKmRldiA9IGludGVs
X2RzaS0+YmFzZS5iYXNlLmRldjsKLQlzdHJ1Y3QgZHJtX2k5MTVfcHJpdmF0ZSAqZGV2X3By
aXYgPSB0b19pOTE1KGRldik7Ci0Jc3RydWN0IGludGVsX2Nvbm5lY3RvciAqY29ubmVjdG9y
ID0gaW50ZWxfZHNpLT5hdHRhY2hlZF9jb25uZWN0b3I7Ci0Jc3RydWN0IG1pcGlfY29uZmln
ICptaXBpX2NvbmZpZyA9IGNvbm5lY3Rvci0+cGFuZWwudmJ0LmRzaS5jb25maWc7Ci0KIAlp
ZiAoaW50ZWxfZHNpLT5ncGlvX3BhbmVsKSB7CiAJCWdwaW9kX3B1dChpbnRlbF9kc2ktPmdw
aW9fcGFuZWwpOwogCQlpbnRlbF9kc2ktPmdwaW9fcGFuZWwgPSBOVUxMOwpAQCAtOTg3LDEz
ICs5ODksNCBAQCB2b2lkIGludGVsX2RzaV92YnRfZ3Bpb19jbGVhbnVwKHN0cnVjdCBpbnRl
bF9kc2kgKmludGVsX2RzaSkKIAkJZ3Bpb2RfcHV0KGludGVsX2RzaS0+Z3Bpb19iYWNrbGln
aHQpOwogCQlpbnRlbF9kc2ktPmdwaW9fYmFja2xpZ2h0ID0gTlVMTDsKIAl9Ci0KLQlpZiAo
KElTX1ZBTExFWVZJRVcoZGV2X3ByaXYpIHx8IElTX0NIRVJSWVZJRVcoZGV2X3ByaXYpKSAm
JgotCSAgICBtaXBpX2NvbmZpZy0+cHdtX2JsYyA9PSBQUFNfQkxDX1BNSUMpCi0JCWdwaW9k
X3JlbW92ZV9sb29rdXBfdGFibGUoJnBtaWNfcGFuZWxfZ3Bpb190YWJsZSk7Ci0KLQlpZiAo
SVNfVkFMTEVZVklFVyhkZXZfcHJpdikgJiYgbWlwaV9jb25maWctPnB3bV9ibGMgPT0gUFBT
X0JMQ19TT0MpIHsKLQkJcGluY3RybF91bnJlZ2lzdGVyX21hcHBpbmdzKHNvY19wd21fcGlu
Y3RybF9tYXApOwotCQlncGlvZF9yZW1vdmVfbG9va3VwX3RhYmxlKCZzb2NfcGFuZWxfZ3Bp
b190YWJsZSk7Ci0JfQogfQotLSAKMi40MS4wCgo=

--------------ut2CYh1xth06y9kfNtp1tqdw--

