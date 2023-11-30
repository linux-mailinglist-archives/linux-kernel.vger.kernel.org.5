Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A5F7FFAF6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376289AbjK3TPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjK3TPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:15:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95062106
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701371715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QaDt2NWj0VcEPGAu3rPNwrwu8X8kzCzHOAGmxbpNQlU=;
        b=Zxpev+He6rD70/8+nJpxCw99NosEwLhGzY6MynCT+skP5xkFVmX8fyR8pNZU/5tih/NUhX
        Y74xRzP6nCuwqaEiVjfLxXC9qD80cXDiwaDTZceV8cbSAHMddGCnozwuuQ/VwC91nigceL
        jHM0tQOOtkVGm0A607W6vWzCVibMwRo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-oOPv6GZUM4-liMzxmp4snA-1; Thu, 30 Nov 2023 14:15:13 -0500
X-MC-Unique: oOPv6GZUM4-liMzxmp4snA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-54bc66b3726so1002371a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:15:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701371711; x=1701976511;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QaDt2NWj0VcEPGAu3rPNwrwu8X8kzCzHOAGmxbpNQlU=;
        b=rXBQkLPIXKlpC2+zgkc5apnfu0dyWiW+dds8ZsOoCRstlrXjE4rNKJZsIRHmusYREo
         HOEqCo7UAEXxxwRIM6W43ezaz9LWogOzyop3yv8cTp0DF3H51DGH8MMLIgavkDeD89Zr
         /rkCQT9SS4mSB5SsIQdOzWZ8yTahJoFzCsBOWQYKfGKVKyh6oAgWciFjSQI+2js4qq5r
         N7EFDOFUvj9+y4PqzI3P7iyzNxgIR+0yhC1jgfRmp6Tw0A/ldk1OC4l4pDiXla6xrSFM
         LbQ4tXUaS55/R5dxNhFjFpQR+yLkZQQ15gqM5eMl3qUDMrFUuxhT678tPbCrAAGZFs5S
         AhuQ==
X-Gm-Message-State: AOJu0YyL166FtIhwQ6wST7GO5xpb/GyKXYYpcIRXOKrSEdAP+RrY/dIT
        3H4vYEzXIPxpiby4P1tpQk3icqmWmcTkxPQ27cXy/D2ZJb997hZE9XFsj8pRXIzawacbqFIC23s
        oCOghT4Z1pcR3EdNbIiPLK0HrnoAbzf9i
X-Received: by 2002:a50:d6c9:0:b0:54b:a7b:8198 with SMTP id l9-20020a50d6c9000000b0054b0a7b8198mr25787edj.17.1701371709600;
        Thu, 30 Nov 2023 11:15:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdphK/loP/z/u3KEHI9MgK1+EX6Se565Rx1rK2c2OAM42riyCiA6+jugSv7PqbgFcgNUVf3w==
X-Received: by 2002:a2e:a445:0:b0:2b9:412a:111d with SMTP id v5-20020a2ea445000000b002b9412a111dmr21246ljn.42.1701365088186;
        Thu, 30 Nov 2023 09:24:48 -0800 (PST)
Received: from starship ([5.28.147.32])
        by smtp.gmail.com with ESMTPSA id e20-20020a2e8ed4000000b002c9c5dd4921sm189164ljl.67.2023.11.30.09.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 09:24:47 -0800 (PST)
Message-ID: <9a8e3cb95f3e1a69092746668f9643a25723c522.camel@redhat.com>
Subject: Re: [PATCH] KVM: x86: Allow XSAVES on CPUs where host doesn't use
 it due to an errata
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 30 Nov 2023 19:24:45 +0200
In-Reply-To: <ZWTQuRpwPkutHY-D@google.com>
References: <c858817d3e3be246a1a2278e3b42d06284e615e5.1700766316.git.maciej.szmigiero@oracle.com>
         <ZWTQuRpwPkutHY-D@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-11-27 at 09:24 -0800, Sean Christopherson wrote:
> On Thu, Nov 23, 2023, Maciej S. Szmigiero wrote:
> > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > 
> > Since commit b0563468eeac ("x86/CPU/AMD: Disable XSAVES on AMD family 0x17")
> > kernel unconditionally clears the XSAVES CPU feature bit on Zen1/2 CPUs.
> > 
> > Since KVM CPU caps are initialized from the kernel boot CPU features this
> > makes the XSAVES feature also unavailable for KVM guests in this case, even
> > though they might want to decide on their own whether they are affected by
> > this errata.
> > 
> > Allow KVM guests to make such decision by setting the XSAVES KVM CPU
> > capability bit based on the actual CPU capability
> 
> This is not generally safe, as the guest can make such a decision if and only if
> the Family/Model/Stepping information is reasonably accurate.

Another thing that really worries me is that the XSAVES errata is really nasty one - 
AFAIK it silently corrupts some registers.

Is it better to let a broken CPU boot a broken OS (OS which demands XSAVES blindly),
and let a silent data corruption happen than refuse to boot it completely?

I mean I understand that it is technically OS fault in this case (assuming that we
do provide it the correct CPU family info), but still this seems like the wrong thing to do.

I guess this is one of those few cases when it makes sense for the userspace to
override KVM's CPUID caps and force a feature - in this case at least that
won't be KVM's fault.


Best regards,
	Maxim Levitsky

> 
> > This fixes booting Hyper-V enabled Windows Server 2016 VMs with more than
> > one vCPU on Zen1/2 CPUs.
> 
> How/why does lack of XSAVES break a multi-vCPU setup?  Is Windows blindly doing
> XSAVES based on FMS?
> 


