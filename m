Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302927EEB96
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 05:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345658AbjKQEQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 23:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKQEQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 23:16:18 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FC01A5;
        Thu, 16 Nov 2023 20:16:15 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6ce2ee17cb5so823909a34.2;
        Thu, 16 Nov 2023 20:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700194574; x=1700799374; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s0pRml4UbUCFGgeFvuEdYG1JjP5SjBhqOmjNulrwupY=;
        b=FV47go9OZNgD1Qtx35+vGJq+fI8BeiAQQ4MkfGx6OG8jPmXCW/kH3jCz6/YoGCPn05
         ZrR128aQY/2HnRw8LQbi1P3zIdmSwm5ieVmQcTE66BYae7dYR4oIJyulxMWOU1zovmxf
         oqsITrGOjE7rcUvqun/JeEyE8Ufqyd1xVbcuuiEDhTe7vSG+EEYxh8sVvkkNYNbypqoa
         yknwm7fPWK8bLt+9Fl5VkrqpYlNuiB8n/eitBFcwulLQsDZwbHXcWPAaG61r6o9rwzVX
         csplpVT7tSqjqT4bO3SJVJiN+hP5NXnTqB0jtcXD6gVNqUfw8isR/bditCOwhm3aaz6l
         s0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700194574; x=1700799374;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s0pRml4UbUCFGgeFvuEdYG1JjP5SjBhqOmjNulrwupY=;
        b=K1UZW/6CZESybl2kiYymtvvrV0QzSbmyeIS0DWLNiQiZCKd0SLysEaD6ZJ0seuSkpb
         x6sV4y3j49pvMFN5s7tE9cj2qHe1LC/gYzGgIxlpvaTKobrjgvx/Wx5NQBidvO7kgHFG
         i/tDmEJYIvnPGWZ8Pz2K2ZJIn1raHeAcZxQQ6HMHXgixcd+SPoXWcBEd0xFkn8slOedZ
         PvOtNZEq3SkAKY1PXQtz7Bo4M0TC5nQAZZ8cSuhi3GDFkw0SU4/vdflMWvnPJlSwqtIp
         qdx24D0n5JBsJ2JR3kxJkWY/GP+7X0VD2EkNRFJS8wHeagZvf8maDYry8JAYfRYxTb1r
         SyFg==
X-Gm-Message-State: AOJu0YygzlfROWuwrY4JUXQMtHmTjQa4toZyxud1yUkNFeX9QZpWrISl
        87MKAHbSRruLhmnumT8/OTc=
X-Google-Smtp-Source: AGHT+IHqSGYNZe+p9rpMhNdWcSO96mJzQypDORJ4+HZbbq3eCBx9k9JoQvFAsEaqrOMkfPqf57THnw==
X-Received: by 2002:a9d:6244:0:b0:6ce:29cd:b699 with SMTP id i4-20020a9d6244000000b006ce29cdb699mr11397480otk.10.1700194574472;
        Thu, 16 Nov 2023 20:16:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f37-20020a635125000000b005a9b20408a7sm502148pgb.23.2023.11.16.20.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 20:16:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 16 Nov 2023 20:16:12 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     PeterYin <peteryin.openbmc@gmail.com>
Cc:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joel Stanley <joel@jms.id.au>,
        Chanh Nguyen <chanh@os.amperecomputing.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: hwmon: Add mps mp5990 driver bindings
Message-ID: <140086a7-c89d-48b7-9574-7db28dcc056e@roeck-us.net>
References: <20231113155008.2147090-1-peteryin.openbmc@gmail.com>
 <20231113155008.2147090-2-peteryin.openbmc@gmail.com>
 <a3445201-58f2-42c6-bef7-ca6968fd80d6@roeck-us.net>
 <69657f96-4849-4134-911d-4785d5d6b8d8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69657f96-4849-4134-911d-4785d5d6b8d8@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 11:18:47AM +0800, PeterYin wrote:
> 
> 
> Guenter Roeck 於 11/16/23 06:27 寫道:
> > On Mon, Nov 13, 2023 at 11:50:07PM +0800, Peter Yin wrote:
> > > Add a device tree bindings for mp5990 device.
> > > 
> > > Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > 
> > What branch is this patch based on ? git fails to apply it.
> > 
> > Guenter
> I think I don't pull the last version. I can rebase it and push the new
> version. Thanks for your feedback.

Question is: Last version of what ? Best would be if it was based
on mainline.

Thanks,
Guenter
