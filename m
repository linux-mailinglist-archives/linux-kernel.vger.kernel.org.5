Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F9F7ADA0A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjIYO03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjIYO01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:26:27 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0D2B6;
        Mon, 25 Sep 2023 07:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695651961; x=1696256761; i=w_armin@gmx.de;
 bh=aK80aM0DExTUCpgh0aMCWfWffCvEYaC3NlqEnhh2tjc=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=s5As3/rz20XFTPpByQ2bqvlfVNbHMs/SvRDIAXJX9nwAHuxGTuMuxgVJbmflybwOSoVKEQG7/x9
 GJRSAuS9h3OQOIAUIWB0oFj+Z8colaPWxv2xUWXzFSHmyYRn8DZqbj0kSRQVadZJ/01w99JZ6gp+/
 hfih257V+sQSW1+chduTiXH4IVK0U08+G65zc9cv8KTqfHK5ty4retxkyGcARH7+SDprH8cXNvF87
 pCSqwIDH0nxdwNBQftKEvZhmPQZGGTX51YNrFI9y/3aUT4gj4DJjx43bUi8Cyua9LsZADpVleTWO8
 cMT7qzEHTIgrbywjAKKhis2j6URC7Sedu4KA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUXtY-1rBHb71vhQ-00QPzi; Mon, 25
 Sep 2023 16:26:01 +0200
Message-ID: <e3c2e050-ce9b-c45d-6918-44384f8d10f6@gmx.de>
Date:   Mon, 25 Sep 2023 16:26:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [External] [PATCH] platform/x86: think-lmi: Fix reference leak
Content-Language: en-US
To:     Mark Pearson <markpearson@lenovo.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230923204154.86815-1-W_Armin@gmx.de>
 <8e1592dd-7e95-20a6-15e7-f21798af3d37@lenovo.com>
From:   Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <8e1592dd-7e95-20a6-15e7-f21798af3d37@lenovo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k1Wm96zYmS4Tdaqn9ACb20hIuP9E/md7IlRH14GzZYvcux/RJKj
 rGqy3IRHQbdTaVaTikYcoIpotxb0a+7vv/hp52LVK/jOFbykUMHgJQVDg1u33pBNJzxLvY9
 pMLp78nK6d5lmjKX+qpd1QLHjXAPQ9P7yADAtXF3Pkvgv+Xm4EYkyo2Y7m/DsN1ur0cTo8E
 FOWGNaZ0h6iVxxPFqIAlA==
UI-OutboundReport: notjunk:1;M01:P0:CPIN7LPOP3M=;q02l1TqudyDj+/HE+p0zWCwrvxt
 6m1vj2Xmo0fXR1QFDCyjDbEVp9I6x0UmuaVCrP9pxuH2mIbXJOXvqtkh8yBbc1xYJiDuvNe5c
 YIHZ9OcokvPLlTT/nqlbkR0PkvV8v6UIPMimB/rdFCcDnvp8qWcLxSIbdJsrh960u7c1SErle
 EE76FB33RwZUON0jrfqKHBM5V00tufFokUI8gDwgkPUB3t2e2snwROSN1ujnPDFfW+uU4yPh8
 nOykyGL85RBb9An/6mGP+vYCq2a6xUCbmTG08PPmDaaE9EbBgvYrzq6x8iVfmGzbzDbQfuTBh
 3vqSog01k+Q87A2JY/HN5LV5FkwckOmUNGfS4gA2qNy7Wt5nII+4x6wFOhI1MxqBFujcJIzNn
 JRhjv00dl5v/1b8aCXhuwSTknoU+aD00TrhUKP0xJx7dJd+JA3pXJe1WpVSRSiJ6+GwN9Asgt
 Jlrl6lGRWSaeiseLAvD6TzZ268cFs7zahd3kaIPhTsFU0i18Ky51aLkCKXfWEhAoL/rCy3uIU
 roVvcTb/E6zJHhra2ztvfg27NIysbUhBO7Y8Z7C0YO+lMskQLp1K3myG/w6Gt8wu3BY/wIFb7
 jFXn1uu48YuO48ipIbhRWKz22/duPuBZF8P1FfMfY7Li0oICymvptpzrWjAqIAE6JQcRj+9Ns
 VDeBSwIUQ8yBInIvyI7CHrTqxTU8Y3zGEgb0eUPphW2vSZFfEOm1tRZUzWGKtvfdk26XzJPAF
 8Snt+XTo1O7X6+t2ZTaxkNMxXbXlpGRroT1ecf687Jjngnmd1AR4IXC1n6865f4uSC4mLB8ym
 GLM+bm0jd/rTFyVwKO2kAdbApugnaEe97ilkNdzhkfNgOPKlxilcppmEw4YPlv1ru8lu1EaxB
 1G9IgjNgyi09gup/jktPtcpsU2ssBi0k9EaugJgHV5kJuJejYCO6iZjiAB55lto35Zyp3aAFR
 RoyqhW6RMgIfsObueirczjSOgcI=
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 25.09.23 um 16:00 schrieb Mark Pearson:

> Thanks Armin,
>
> On 9/23/23 16:41, Armin Wolf wrote:
>> If a duplicate attribute is found using kset_find_obj(), a reference
>> to that attribute is returned which needs to be disposed accordingly
>> using kobject_put(). Move the setting name validation into a separate
>> function to allow for this change without having to duplicate the
>> cleanup code for this setting.
>> As a side note, a very similar bug was fixed in
>> commit 7295a996fdab ("platform/x86: dell-sysman: Fix reference leak"),
>> so it seems that the bug was copied from that driver.
>>
>> Compile-tested only.
>>
>> Fixes: 1bcad8e510b2 ("platform/x86: think-lmi: Fix issues with
>> duplicate attributes")
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>> =C2=A0 drivers/platform/x86/think-lmi.c | 24 ++++++++++++++++++++----
>> =C2=A0 1 file changed, 20 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/platform/x86/think-lmi.c
>> b/drivers/platform/x86/think-lmi.c
>> index 4be6f28d4600..3a396b763c49 100644
>> --- a/drivers/platform/x86/think-lmi.c
>> +++ b/drivers/platform/x86/think-lmi.c
>> @@ -1344,6 +1344,24 @@ static void tlmi_release_attr(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kset_unregister(tlmi_priv.authentication=
_kset);
>> =C2=A0 }
>>
>> +static int tlmi_validate_setting_name(struct kset *attribute_kset,
>> char *name)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct kobject *duplicate;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!strcmp(name, "Reserved"))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> +
>> +=C2=A0=C2=A0=C2=A0 duplicate =3D kset_find_obj(attribute_kset, name);
>> +=C2=A0=C2=A0=C2=A0 if (duplicate) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_debug("Duplicate attribu=
te name found - %s\n", name);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* kset_find_obj() returns =
a reference */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kobject_put(duplicate);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EBUSY;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> =C2=A0 static int tlmi_sysfs_init(void)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i, ret;
>> @@ -1372,10 +1390,8 @@ static int tlmi_sysfs_init(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 continue;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* check for dup=
licate or reserved values */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (kset_find_obj(tlmi_priv=
.attribute_kset,
>> tlmi_priv.setting[i]->display_name) ||
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !st=
rcmp(tlmi_priv.setting[i]->display_name, "Reserved")) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_=
debug("duplicate or reserved attribute name found -
>> %s\n",
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 tlmi_priv.setting[i]->display_name);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (tlmi_validate_setting_n=
ame(tlmi_priv.attribute_kset,
>> + tlmi_priv.setting[i]->display_name) < 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 kfree(tlmi_priv.setting[i]->possible_values);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 kfree(tlmi_priv.setting[i]);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 tlmi_priv.setting[i] =3D NULL;
>> --
>> 2.39.2
>>
>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>
> Do you have any reports of our platforms where these are seen? If so
> I'd like to get it fixed in FW too (and I can get it tested on HW if
> that helps)
>
> Mark
>
No, i do not have any reports regarding this issue. I stumbled upon this b=
ug by chance, after fixing a similar bug in dell-wmi-sysman.
I suspect that the bug was copied from there to the other drivers, like th=
ink-lmi and hp-bioscfg.

Armin Wolf

