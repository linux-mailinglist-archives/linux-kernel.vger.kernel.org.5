Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6277E8112E6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379120AbjLMNba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378978AbjLMNb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:31:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AD5AB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702474293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dC8eAG+rdDz771HyG+6UKW1N21lq1IFcm8wzo/9j4Ag=;
        b=gJJqpHn6P9DZfGowORawvXOVVYLVpHsrgWGfPv+L9Tw8bl/SgW2brt7Or4lI6SvhR/AYc+
        RGKVpGBkSLbzBkTPpDmDt24zKaGS4Ll8D1g+nIUpNEe6tkAyZmcKDUvll3Rmq35D7nOBwy
        XkHA/A1hvcafWQYiPQPyrBjJKnXcAKE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-F4EK995WPh-5vfdLlp9vAA-1; Wed, 13 Dec 2023 08:31:32 -0500
X-MC-Unique: F4EK995WPh-5vfdLlp9vAA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a1f93205e60so160562566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:31:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702474291; x=1703079091;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dC8eAG+rdDz771HyG+6UKW1N21lq1IFcm8wzo/9j4Ag=;
        b=B+ShOHUR6WXclecGlQPge5Q8Waw9gwchDFK3SHtD3f26rZIQILdrymQBnf5BesC/9x
         tk74VwQfY8hloid+aqs5MYMlODpVUYI6DAROSMPM4hSpc0vbsx1PQ1bCCAGVt5Tz6Mea
         e11X6SGIr8cIeoQ2tTsXO/erIHL79simZlqASJQ2n/sQXGiZ9eaQjXRuzgD47o5JdEXS
         FzMmLoL2YMHPed69/i8L5HN0oDyOiGw/l7FEE/1YsdOzg7P9qtAJXNfMmotc+xoNmkUk
         7fO66WZKRakQijCIIceOTjJhGy38IkF2ZAve7hqJ4f/aojUscnFi+bFpQjPmCKXfXow/
         WRuw==
X-Gm-Message-State: AOJu0Yw3Mp0Y5gJodJ56e0i3QNU+OBmWYW3P2mGMhL5itnnyYo9brJn0
        zh+sBvR6FJShxLWZ2O2vIc0XiX1uu9ArxT/YLEdsGRoP4uI0+w2DFKQOk8gwXfHn5onI4ZvfVXn
        q1DVYqTFEsdmli8SImtjdf40b
X-Received: by 2002:a17:906:b204:b0:a19:a1ba:8ce0 with SMTP id p4-20020a170906b20400b00a19a1ba8ce0mr3653207ejz.126.1702474290993;
        Wed, 13 Dec 2023 05:31:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMRBYvxquPjKh2oUpzsQZ4YofuMOR/BRB0u9Mr+JzAm33S9FD+0/e2kUugVLkdr9DckuEDFQ==
X-Received: by 2002:a17:906:b204:b0:a19:a1ba:8ce0 with SMTP id p4-20020a170906b20400b00a19a1ba8ce0mr3653199ejz.126.1702474290682;
        Wed, 13 Dec 2023 05:31:30 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id tg10-20020a1709078dca00b00a178b965899sm7819372ejc.100.2023.12.13.05.31.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 05:31:30 -0800 (PST)
Message-ID: <a2e25f7c-dd5b-4c88-b25a-4d8ddc8b7f29@redhat.com>
Date:   Wed, 13 Dec 2023 14:31:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3] KVM: selftests: Initialise dynamically
 allocated configuration names
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Haibo Xu <haibo1.xu@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231211-kvm-get-reg-list-str-init-v3-1-6554c71c77b1@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20231211-kvm-get-reg-list-str-init-v3-1-6554c71c77b1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/23 14:08, Mark Brown wrote:
> When we dynamically generate a name for a configuration in get-reg-list
> we use strcat() to append to a buffer allocated using malloc() but we
> never initialise that buffer. Since malloc() offers no guarantees
> regarding the contents of the memory it returns this can lead to us
> corrupting, and likely overflowing, the buffer:
> 
>    vregs: PASS
>    vregs+pmu: PASS
>    sve: PASS
>    sve+pmu: PASS
>    vregs+pauth_address+pauth_generic: PASS
>    X�vr+gspauth_addre+spauth_generi+pmu: PASS
> 
> Initialise the buffer to an empty string to avoid this.

> diff --git a/tools/testing/selftests/kvm/get-reg-list.c b/tools/testing/selftests/kvm/get-reg-list.c
> index be7bf5224434..dd62a6976c0d 100644
> --- a/tools/testing/selftests/kvm/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/get-reg-list.c
> @@ -67,6 +67,7 @@ static const char *config_name(struct vcpu_reg_list *c)
>   
>   	c->name = malloc(len);
>   
> +	c->name[0] = '\0';
>   	len = 0;
>   	for_each_sublist(c, s) {
>   		if (!strcmp(s->name, "base"))
>  			continue;
>  		strcat(c->name + len, s->name);

This can be fixed just by s/strcat/strcpy/, but there's also an ugly 
hidden assumption that for_each_sublist runs at least one iteration of 
the loop; otherwise, the loop ends with a c->name[-1] = '\0';

>                 len += strlen(s->name) + 1;
>                 c->name[len - 1] = '+';
>         }
>         c->name[len - 1] = '\0';

Now this *is* a bit academic, but it remains the fact that all the 
invariants are screwed up and while we're fixing it we might at least 
fix it well.

So let's make the invariant that c->name[0..len-1] is initialized.  Then 
every write is done with either strcpy of c->name[len++] = '...'.

> ---
> base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
> change-id: 20231012-kvm-get-reg-list-str-init-76c8ed4e19d6
> 
> Best regards,

