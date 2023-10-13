Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDF27C887C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjJMPU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbjJMPU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:20:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C34CF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697210413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k/AuDIRzij+kWm5ZIXiIa6zntO0S2SYmaTGa19iHgWE=;
        b=gBQL8yRkiQTnqRH+5f5Z3CZ4A3iVrQZmlCVCXNAwaOrv7OmYvD8Q/N+Z/0/8OEv7ss3hMj
        2toH1HWp/1VCDvo1WjHkUpfgbUuO7R+LuQE15Pgr9clUrUNuJdwS11b5428EM8COukjMJ8
        nG8IrpNOY9nGatREz1EyUl1xgB8vin8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-ts5xFpSuPgCzkQt4W8o4OQ-1; Fri, 13 Oct 2023 11:20:11 -0400
X-MC-Unique: ts5xFpSuPgCzkQt4W8o4OQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-32d9cd6eb0bso420498f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:20:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697210410; x=1697815210;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k/AuDIRzij+kWm5ZIXiIa6zntO0S2SYmaTGa19iHgWE=;
        b=BnG902drfT1RwifL1iVuqsYBsm994zOqw90ZAgIlt8V7TbrtohclnfKRwreoDeoJAT
         JMunEz6Ylw3qoAnLpPqgmNvyFREtHUXbNokj5pEK3BXxVRQwW86ahR8wKowX9YbXR+WP
         hjoh5riA6MMSaY3QXrsn/eUIFH2GuUuk8Kuy47gQ62eHKewl3FoBjH/p9QDl+l8mfbbW
         5RUGW8gl1oW4IJk8vx8oArlF8BdKRykHt8fDmDa4/a4n4BAdmmRFPNyX45qt7UXCtW5I
         aONfVg3avJoyulLtDQQGftGMP3ZT3uGDqelpiaSJ5Y9njPk3d8n3W8oJ5cdfH8dC5Cqy
         u+/w==
X-Gm-Message-State: AOJu0Yw2cUKWUV+r6F0j6dvNL09qEdWfKPFeoAXpIYIzPu06nqoBvufY
        ZX9CF2xwv6qgb02k1dV0qKEirbQ/605ulqT80wLslVsjrx/f143bNZrtJwcx5xF4HtKMO6l60Il
        htGsqHOGCnrlGf+j+iAXW8ZjRXxiYuLNn
X-Received: by 2002:a5d:4402:0:b0:32d:8907:2b18 with SMTP id z2-20020a5d4402000000b0032d89072b18mr6639640wrq.66.1697210410185;
        Fri, 13 Oct 2023 08:20:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGEAmpZE3P7fyIbvO0lrP+ZBuqaIET5uU3Qr8HuZR7EYE0qwIBfig1qZvB8TZA6vC0WREO5A==
X-Received: by 2002:a5d:4402:0:b0:32d:8907:2b18 with SMTP id z2-20020a5d4402000000b0032d89072b18mr6639624wrq.66.1697210409848;
        Fri, 13 Oct 2023 08:20:09 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600001c900b0032179c4a46dsm20991487wrx.100.2023.10.13.08.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 08:20:09 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <mripard@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        dri-devel@lists.freedesktop.org, Conor Dooley <conor@kernel.org>,
        Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v3 4/6] drm/ssd130x: Add support for the SSD132x OLED
 controller family
In-Reply-To: <21ed30ec-506d-4a4b-b787-37b054285914@suse.de>
References: <20231012213843.1151060-1-javierm@redhat.com>
 <20231012213843.1151060-5-javierm@redhat.com>
 <6740c736-ba5f-4df2-ba2b-da0902f51f6d@suse.de>
 <87bkd2sh77.fsf@minerva.mail-host-address-is-not-set>
 <21ed30ec-506d-4a4b-b787-37b054285914@suse.de>
Date:   Fri, 13 Oct 2023 17:20:08 +0200
Message-ID: <87zg0m35xz.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

[...]
 
>> As you mention that these could be follow-up changes, I assume that you
>> agree with the current approach. Should I expect your review / ack for
>> this patch-set?
>
> Please take my ack for this patchset
>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>

Perfect, thanks a lot!

> Best regards
> Thomas
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

