Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6757810B3E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 08:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378662AbjLMHOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 02:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbjLMHOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 02:14:38 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3648D4B;
        Tue, 12 Dec 2023 23:14:28 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5e176babd4eso23797907b3.2;
        Tue, 12 Dec 2023 23:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702451668; x=1703056468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+4lQ/n2/Aooh3HLrGXdGkcUlpQ+xQAxZM0f/fJu9eb8=;
        b=lY+TJdQf8e7CJYW2MpDVB7jOjPt4v45zvtXqpctdwmQhY0FKrp2nGgcpY42njiiQDy
         UFXge8o9Jcw7NDnLm+zAtQDWg2b1mNXk7xmioBo6/+YLa1RmdnO6hubTbq+mBhimLR6b
         74kiChPu5mZJk3OEMQA40W5wW4kb7bH5BNVJO/8W7kslTnbSjwbuNmrnAPZKVU7ETUk9
         XZ48l3o0JN+aK7evHkA72PirOU3JjiNO+5JeRciX03i0V4xgRll0S+fNRKSNJ5do3UkE
         9BtsZuiRmQMpUgdc7Z5oAwIp49kRYiH7axCp1yHmB9y//pmR5JqzzcgItDMtknWtvEwv
         y8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702451668; x=1703056468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4lQ/n2/Aooh3HLrGXdGkcUlpQ+xQAxZM0f/fJu9eb8=;
        b=eGiyyIzDXqPlSRL3AZcew8fSblMeuJGAyJIhKV2YE/j13ePvEtSgvXhSTvKXHsUbVN
         GezOCc3YjXWL12fnjlax4HIN0iJv5LDJO63/HO5izL1OjnQeQn6fg7RW/of4dty2bsFi
         rNJ4uC4MGgE/YELXAkAZ40oh50X7psjdfUt0YQq4NL7TZb/g/P1sO0m3v2vg41j68+b8
         /HhRdirohaOzb826AL+cnneVaU7R5gr5d+je2LsewYMn/sPUtVI58z5khmqyVx1j/ZF8
         aDnP4KhicVqn1i9TmYMQUDXSaU6abGk41uDDsRldkU48l9VKzxeMpmQqqypZIokyspCL
         XoKA==
X-Gm-Message-State: AOJu0Yw4GALO3Mz9ZCDRkWamzANXxl/z691psP82tKvzhB8Rfx/TPeJd
        +w14pcSSyfxoNRbVCyTPjflTmSJAAuiXZg==
X-Google-Smtp-Source: AGHT+IHfDPJCUPSeq4XDUWQHJAokM3yftuwn8RagApGbgpYHpfYiBx5vbT6ITl4KZKWwd62YkOVYXg==
X-Received: by 2002:a0d:f347:0:b0:5d7:1940:53df with SMTP id c68-20020a0df347000000b005d7194053dfmr6509375ywf.87.1702451667654;
        Tue, 12 Dec 2023 23:14:27 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:96c1:256f:67e0:c0db])
        by smtp.gmail.com with ESMTPSA id t6-20020a170902bc4600b001d343a978a7sm1668374plz.220.2023.12.12.23.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 23:14:27 -0800 (PST)
Date:   Tue, 12 Dec 2023 23:14:24 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: input: gpio-keys: Allow optional
 dedicated wakeirq
Message-ID: <ZXlZ0I1mdtvbSL6H@google.com>
References: <20231129110618.27551-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129110618.27551-1-tony@atomide.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 01:06:14PM +0200, Tony Lindgren wrote:
> Allow configuring an optional dedicated wakeirq for gpio-keys that
> some SoCs have.
> 
> Let's use the common interrupt naming "irq" and "wakeup" that we already
> have in use for some drivers and subsystems like i2c framework.
> 
> Note that the gpio-keys interrupt property is optional. If only a gpio
> property is specified, the driver tries to translate the gpio into an
> interrupt.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Applied, thank you.

-- 
Dmitry
