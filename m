Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AFF8118FD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbjLMQRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjLMQRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:17:49 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9113C91;
        Wed, 13 Dec 2023 08:17:55 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id ffacd0b85a97d-334af3b3ddfso6429141f8f.3;
        Wed, 13 Dec 2023 08:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702484274; x=1703089074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYwjbmQZvwU9u+tDTStkrBp879h/qJAV7gt0FsFFyr0=;
        b=l8ob610xtjBhDriJ2TRioQ3IKw7MIWHDroWjrKae9gaEDKn5AImD1KHnK+Dk1ZWmas
         hqJn/3qRaNpfx8nY3w4frA4IbG/pEl1HkPl+AiiwkNxWTGGnkXYgKEq1OhPd2vQIV2ef
         RcMJRKuBRq/HSpnGi8B6hM5zZoLv6Ux7zS+12RQ69Wi9ywVfRbgrPqop33+KDnD6jzNb
         Lx7tiPn8i2gxs6wDb6z6OZWrVggCeM4lAuUNtbEU/uKZcSjk0TKw3iNftoJIMK3961P8
         /+KS9bXK0BG2nhHZjnqpAY6kvKkPAconHJHHefYArSs09m7g72pJRzVecnWJ8wKaCvJ9
         mscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702484274; x=1703089074;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YYwjbmQZvwU9u+tDTStkrBp879h/qJAV7gt0FsFFyr0=;
        b=ktAmnS5M9h43IxAZYw5wXNVY0WvBNBH7lT21EvXmbjJgVFa/qKh/VKddw1cE3W6GEY
         LKHlRXG9fXmyOPcJJdZA9WAA780+Iqvz7DhXyoPAqIWYj5x0jdnvizlBMhdGmtMzADcO
         KWoYLOYQviWVhTGWizD3ED58PIPO47tXY17/dt4SSD74RfIuVeUG+B7KDozI/eCELiRM
         9ZdKYxWBlEwdZOe4Rh29d37imP3ZC9mB0/kUMBLUuxoYrED5DNL3gJqtD8TCd1XknyOg
         sAfO3nX5hPuojuUHjTyGH/PQTGofZojmG8ycLsXXd6WD31PRT5OAtG8lFiuMaRDXCrcY
         rWTA==
X-Gm-Message-State: AOJu0YyjcxDd/9X9hub5kj1TURDGSPBoBQYNrd80F1G3GTugFYPFHGjB
        Nymefm+tLpKuWF7Cx39VPUs=
X-Google-Smtp-Source: AGHT+IEuk7cpS30EevJFdVqCIgZsvbUfFPHjkNCwYecbWToBFPMTp4fNK0vURG6kMB8ydeDh2TAHZQ==
X-Received: by 2002:adf:f70f:0:b0:333:3af7:a4ef with SMTP id r15-20020adff70f000000b003333af7a4efmr3661275wrp.8.1702484273856;
        Wed, 13 Dec 2023 08:17:53 -0800 (PST)
Received: from localhost ([217.212.240.69])
        by smtp.gmail.com with ESMTPSA id m18-20020a5d6a12000000b003364492703csm45088wru.23.2023.12.13.08.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 08:17:53 -0800 (PST)
Message-ID: <f4079587-9082-4526-8d87-676700740cc3@gmail.com>
Date:   Wed, 13 Dec 2023 17:09:03 +0100
MIME-Version: 1.0
Subject: Re: [PATCH net] ipmr: support IP_PKTINFO on cache report IGMP msg
Content-Language: en-US
To:     Eric Dumazet <edumazet@google.com>
Cc:     davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        leone4fernando@gmail.com
References: <ac24d9b6-bfff-4700-a301-d4bd0dbb9313@gmail.com>
 <CANn89iKEL4ZhL0BkRiY+5vnUQ6vC=eJ=J+gGFg6+CJ7QL8oOjQ@mail.gmail.com>
From:   Leone Fernando <leone4fernando@gmail.com>
In-Reply-To: <CANn89iKEL4ZhL0BkRiY+5vnUQ6vC=eJ=J+gGFg6+CJ7QL8oOjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Eric. I will submit a v2.
