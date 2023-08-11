Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA27A77866E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 06:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjHKEOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 00:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjHKEOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 00:14:30 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3549F;
        Thu, 10 Aug 2023 21:14:29 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bdba48eccdso423795ad.3;
        Thu, 10 Aug 2023 21:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691727269; x=1692332069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSR3Q04lK59tiGJay4SkNer8bq6qRzC22OcRjYST5Xs=;
        b=ixEv7OnX4jkE2gbNOieRXO69/GTH7zq/og7zqDIWbH+/gw6jP/MwDbdgnV45z35rsg
         W2/laVoakXArMI3jrZ/2W4BUrRjZljKaPvgZ5W2DI9HirG2WJ4iaYLvV65qV9jjpfM5Z
         jGZ6RVsQHERM9SswkODBO3BebWfrDrCMvhNIVC8ar4fH6xHv6d3Fj/6pqm9w/4MbVNda
         DV5LsjHSN7CUM6jFD2vavZRqs6ycrNrn1H/UsM/6YyvM5mvOyMIJ2E+dRxeSkgAnPMbC
         z2zPQ6t5HeSBwB17brm2ECR42uRHcWIUPUgubjJumA2T+M8C6x8BmPTxVthOEgeBHNm9
         EviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691727269; x=1692332069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSR3Q04lK59tiGJay4SkNer8bq6qRzC22OcRjYST5Xs=;
        b=RnB7ukjQULThgDJtcd1rpe0eOhIy6bp5K/sQvhsKJQmuEQzIZryF8hEPrPXwKIM/26
         W1q5aP73IdsQg9D5DrUZS2kAYzkXyN5GqXql5cZ55NU4H1YD9DBW5dM4N7ZvI8IfR0u0
         xzEndgIhwTv4pYRn6n2JC8qieGixsxo8tK/2BfLQNfWgWmoxp4hyAsA3OoSuoosZcH+h
         CpgXzC6d62JdPpUhvOedjrJeTBKh22GkaZ/H6QVsAmia0Ywl7EnYiKsUmaKmPk2YDbNS
         V8JGpQM9wFeW8zauOKXI2D2nGCaSe+azi8arQSOSus5QqEwMomBlpdAWfcAmx9TtioaP
         7Xng==
X-Gm-Message-State: AOJu0YxAODdt9sHlwG7PaoGqzw+/pKerVhP1a86WPnFHaqHVLIkn4cAK
        wthK43vro1/qH/4P4xGsV+k=
X-Google-Smtp-Source: AGHT+IEOhiTP3OqfDr24GR4MV2Zif3y73zLGJn4lAgQ4UFvuftuROMI632adJdSQEy0ThczGN6Em/w==
X-Received: by 2002:a17:902:c409:b0:1bc:6c8:cded with SMTP id k9-20020a170902c40900b001bc06c8cdedmr1027879plk.67.1691727269271;
        Thu, 10 Aug 2023 21:14:29 -0700 (PDT)
Received: from localhost ([198.211.45.220])
        by smtp.gmail.com with ESMTPSA id r2-20020a170902be0200b001bb9883714dsm2626522pls.143.2023.08.10.21.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 21:14:29 -0700 (PDT)
Date:   Fri, 11 Aug 2023 12:14:20 +0800
From:   Furong Xu <0x1207@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH 1/1] net: stmmac: dwmac4: extract MAC_HW_Feature regs
 MSB first
Message-ID: <20230811121420.00007a95@gmail.com>
In-Reply-To: <9b9635bd-2635-4115-bafb-8a07573c6556@lunn.ch>
References: <20230810095929.246901-1-0x1207@gmail.com>
        <9b9635bd-2635-4115-bafb-8a07573c6556@lunn.ch>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 15:59:25 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Thu, Aug 10, 2023 at 05:59:29PM +0800, Furong Xu wrote:
> > The bit extraction sequences are a little messy.
> > No code changes, just reorder them.  
> 
> How is this substantially better?
> 
> If bugs are found in this code, your change is going to make it harder
> to back port the fixes to stable kernels. cherry-pick is unlikely to
> work, it will need a human to look at it. Not hard, but still effort
> for somebody.
> 
> So i think there needs to be a clear benefit to this, and you should
> mention the benefit in the commit message.
> 
>     Andrew

Hi Andrew, Alexandre

In Synopsys databook, the description tables about all registers
start with the MSB.
So we can read one line code and then check it against one table row,
and goto next line of code against next row of table.

I agree with that this commit make cherry-pick less compatible.

If the benefit above is not worthy enough, we abandon this commit :)

Thanks.
