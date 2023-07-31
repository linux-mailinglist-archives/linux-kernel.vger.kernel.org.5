Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7C1769BD0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjGaQFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjGaQFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:05:13 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2561708;
        Mon, 31 Jul 2023 09:04:44 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b962c226ceso68493761fa.3;
        Mon, 31 Jul 2023 09:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690819479; x=1691424279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFQVIyO9mnOrt6gUPTnGGI7vO7CmzG/7hd8o8TK6rGc=;
        b=T0oA5Z9jnVsYdRAennfDSerebrWmibM6nku6v/pPxN2b2wtBfjUAwPobVYSuy6J7d+
         lZQo1DHCNFS0g7W2bkAxa+mwpXbU5ngANLYLAJng3bH5in6XJLJNJvPDyBWoWARtIar/
         T/6y5jd3s1fr+qQdWO5qcxlbnicz75vNGLm7H8auyLApir+bIlOztYASKgDPLgecYAqr
         aUH08Z+zcexsWhupYbUGNbJFiCkYOmSEAvAtjiW11erpgnHJb+XOiHRiHDlHbvLm/AeG
         ZrSjWuOnS7qaG4g+8QM1GNaJTjUYFn8LaHorMzzEYIKRbrr15arybL/RD5/yjX/DV60K
         gD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690819479; x=1691424279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XFQVIyO9mnOrt6gUPTnGGI7vO7CmzG/7hd8o8TK6rGc=;
        b=Id83wa9qRmqI0ouV7vS5bqLuhmcuqedvDv2mkADTWmaA/7RrxhLmQfbgfQomBnBbNS
         LT/mJdJvJ/iJqQtVH/cW2maFnUUVM63k7QjP6dKOfiawLxONDxc9uVYAKuNLTEeZ+xxb
         SXBpACoCffzMjr5oesZRkB2z03UWhliPCtyKEmsOBuTmn52Iyem5wzmWnRMQbsWM/Qaf
         XHS+BYRqxDxjzbX0l9hZXTxmprXjlf11RvSSDG1DoN4YshEcyFSHma47jUA4JKteKaw8
         IdZ3TztGeQw3ae56DdBl2jEDYKCnLGz2yOFTPXBk4skq6bUkqUhnPpVFwGtvi9ddMo/9
         QWQA==
X-Gm-Message-State: ABy/qLauyU2metSuv+vqxojaO9Aw2DLu20OCItTIiI6EnfHSANHUSVPW
        f2eybxALhpJoY716biOY+dBWjkd/lWRUFW6ZJM0=
X-Google-Smtp-Source: APBJJlHmK7BXK28CnbtD3BOFiQZXUZFTm0fyitynabL3nSvF1kEn87etYKYjxrfrrPMu9XNOOyR2PkeGXcZ5gDlcnmE=
X-Received: by 2002:a2e:9603:0:b0:2b9:af56:f4b8 with SMTP id
 v3-20020a2e9603000000b002b9af56f4b8mr306842ljh.10.1690819479237; Mon, 31 Jul
 2023 09:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230725220056.25560-1-jorge.lopez2@hp.com> <20230725220056.25560-3-jorge.lopez2@hp.com>
 <77867e93-7785-457c-9e37-4b41503bb509@moroto.mountain>
In-Reply-To: <77867e93-7785-457c-9e37-4b41503bb509@moroto.mountain>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Mon, 31 Jul 2023 11:03:42 -0500
Message-ID: <CAOOmCE_uRxqjTYueZkStbXeU5GKRUnvFOSGNhiBbtWDfkvxveg@mail.gmail.com>
Subject: Re: [PATCH 2/5] hp-bioscfg: Fix memory leaks in ordered_list_elements_from_package
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 1:21=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> I went through this pretty carefully.  There is a small bug in the
> ORD_LIST_ELEMENTS case where the value_len is wrong.  Otherwise, I
> complained a little about style nits...  You can feel free to ignore
> everything except the ORD_LIST_ELEMENTS stuff.
>
> regards,
> dan carpenter
>
> drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
>    129  static int hp_populate_ordered_list_elements_from_package(union a=
cpi_object *order_obj,
>    130                                                            int ord=
er_obj_count,
>    131                                                            int ins=
tance_id)
>    132  {
>    133          char *str_value =3D NULL;
>
> It would be better to make str_value local to the loop.  Then we
> could delete all the str_value =3D NULL assignments and the exit_list:
> code at the end.  At the end of the loop we could do something like:
>
>         kfree(str_value);
>         if (ret)
>                 return ret;
>
>    134          int value_len =3D 0;
>    135          int ret;
>    136          u32 size;
>    137          u32 int_value =3D 0;
>
> It confused me that it's called int_value when it's not an int.  Just
> call it "u32 value =3D 0;".

The variable is named int_value when it is not an int because it
stores the value reported by ACPI_TYPE_INTEGER package.
The variable will be renamed to  type_int_value;
>
>    138          int elem;
>    139          int reqs;
>    140          int eloc;
>    141          char *tmpstr =3D NULL;
>    142          char *part_tmp =3D NULL;
>    143          int tmp_len =3D 0;
>    144          char *part =3D NULL;
>    145          struct ordered_list_data *ordered_list_data =3D &bioscfg_=
drv.ordered_list_data[instance_id];
>    146
>    147          if (!order_obj)
>    148                  return -EINVAL;
>    149
>    150          for (elem =3D 1, eloc =3D 1; elem < order_obj_count; elem=
++, eloc++) {
>    151                  /* ONLY look at the first ORDERED_ELEM_CNT elemen=
ts */
>    152                  if (eloc =3D=3D ORD_ELEM_CNT)
>    153                          goto exit_list;
>
> We really expect to exit when eloc is ORD_ELEM_CNT.  So I think this
> would be more clear as:
>
>         for (elem =3D 1, eloc =3D 1; eloc < ORD_ELEM_CNT; elem++, eloc++)=
 {
>
Done!

> I don't really know what eloc stands for...  dst_idx?
>
>                 if (elem >=3D order_obj_count)
>                         return -EINVAL;
>
>                 obj =3D &order_obj[elem];
>

'eloc' stands for 'element location'.  eloc helps keep track
conditions such when ORD_LIST_SIZE and/or PREREQUISITES_SiZE value is
zero.


> Let's move the "Check that both expected and read object type match"
> stuff from line 173 up to here.
>
>                 if (obj->type !=3D expected_order_types[eloc]) {
>                         pr_err("Error expected type %d for elem %d, but g=
ot type %d instead\n",
>                                 expected_order_types[eloc], elem, obj->ty=
pe);
>                         return -EINVAL;
>                 }
>
>    154
>    155                  switch (order_obj[elem].type) {
>
>         switch(obj->type) {
>
>    156                  case ACPI_TYPE_STRING:
>    157                          if (elem !=3D PREREQUISITES && elem !=3D =
ORD_LIST_ELEMENTS) {
>    158                                  ret =3D hp_convert_hexstr_to_str(=
order_obj[elem].string.pointer,
>    159                                                                 or=
der_obj[elem].string.length,
>    160                                                                 &s=
tr_value, &value_len);
>    161                                  if (ret)
>    162                                          continue;
>
> return ret;
>
>    163                          }
>    164                          break;
>    165                  case ACPI_TYPE_INTEGER:
>    166                          int_value =3D (u32)order_obj[elem].intege=
r.value;
>    167                          break;
>    168                  default:
>    169                          pr_warn("Unsupported object type [%d]\n",=
 order_obj[elem].type);
>    170                          continue;
>
> return -EINVAL;

We encountered during our testing that one or more packages could be
assigned the wrong package type or invalid data..
For this reason, it was decided to ignore any invalid data and
incorrect type package and allow the read process to continue.
>
>    171                  }
>    172
>    173                  /* Check that both expected and read object type =
match */
>    174                  if (expected_order_types[eloc] !=3D order_obj[ele=
m].type) {
>    175                          pr_err("Error expected type %d for elem %=
d, but got type %d instead\n",
>    176                                 expected_order_types[eloc], elem, =
order_obj[elem].type);
>    177                          kfree(str_value);
>    178                          return -EIO;
>    179                  }
>    180
>    181                  /* Assign appropriate element value to correspond=
ing field*/
>    182                  switch (eloc) {
>    183                  case VALUE:
>    184                          strscpy(ordered_list_data->current_value,
>    185                                  str_value, sizeof(ordered_list_da=
ta->current_value));
>    186                          replace_char_str(ordered_list_data->curre=
nt_value, COMMA_SEP, SEMICOLON_SEP);
>    187                          break;
>    188                  case PATH:
>    189                          strscpy(ordered_list_data->common.path, s=
tr_value,
>    190                                  sizeof(ordered_list_data->common.=
path));
>    191                          break;
>    192                  case IS_READONLY:
>    193                          ordered_list_data->common.is_readonly =3D=
 int_value;
>    194                          break;
>    195                  case DISPLAY_IN_UI:
>    196                          ordered_list_data->common.display_in_ui =
=3D int_value;
>    197                          break;
>    198                  case REQUIRES_PHYSICAL_PRESENCE:
>    199                          ordered_list_data->common.requires_physic=
al_presence =3D int_value;
>    200                          break;
>    201                  case SEQUENCE:
>    202                          ordered_list_data->common.sequence =3D in=
t_value;
>    203                          break;
>    204                  case PREREQUISITES_SIZE:
>    205                          ordered_list_data->common.prerequisites_s=
ize =3D int_value;
>    206                          if (int_value > MAX_PREREQUISITES_SIZE)
>    207                                  pr_warn("Prerequisites size value=
 exceeded the maximum number of elements supported or data may be malformed=
\n");
>
>         ret =3D -EINVAL;
>         break;
>
We encountered during our testing that one or more packages could be
assigned the wrong package type or invalid data..
For this reason, it was decided to ignore any invalid data and
incorrect type package and allow the read process to continue.

>    208
>    209                          /*
>    210                           * This HACK is needed to keep the expect=
ed
>    211                           * element list pointing to the right obj=
[elem].type
>    212                           * when the size is zero. PREREQUISITES
>    213                           * object is omitted by BIOS when the siz=
e is
>    214                           * zero.
>
> It's not really a HACK.

Will change the term HACK  to 'step'
>
>         /*
>          * If prerequisites_size is zero then there isn't a PREREQUISITES
>          * object so skip that and jump to SECURITY_LEVEL.
>          *
>          */
>
>
>    215                           */
>    216                          if (int_value =3D=3D 0)
>    217                                  eloc++;
>    218                          break;
>    219                  case PREREQUISITES:
>    220                          size =3D min_t(u32, ordered_list_data->co=
mmon.prerequisites_size,
>    221                                       MAX_PREREQUISITES_SIZE);
>
> If we returned when we hit invalid data then there is no need for this
> min_t().
>
>         size =3D ordered_list_data->common.prerequisites_size;
>
>    222                          for (reqs =3D 0; reqs < size; reqs++) {
>    223                                  ret =3D hp_convert_hexstr_to_str(=
order_obj[elem + reqs].string.pointer,
>    224                                                                 or=
der_obj[elem + reqs].string.length,
>    225                                                                 &s=
tr_value, &value_len);
>
> This is fine but it might be nicer to do what ORD_LIST_ELEMENTS does
> and use tmpstr instead of str_value.
>
>    226
>    227                                  if (ret)
>    228                                          continue;
>
> break;
>
>    229
>    230                                  strscpy(ordered_list_data->common=
.prerequisites[reqs],
>    231                                          str_value,
>    232                                          sizeof(ordered_list_data-=
>common.prerequisites[reqs]));
>    233
>    234                                  kfree(str_value);
>    235                                  str_value =3D NULL;
>    236                          }
>    237                          break;
>    238
>    239                  case SECURITY_LEVEL:
>    240                          ordered_list_data->common.security_level =
=3D int_value;
>    241                          break;
>    242
>    243                  case ORD_LIST_SIZE:
>    244                          ordered_list_data->elements_size =3D int_=
value;
>    245                          if (int_value > MAX_ELEMENTS_SIZE)
>    246                                  pr_warn("Ordered List size value =
exceeded the maximum number of elements supported or data may be malformed\=
n");
>
> ret =3D -EINVAL;
> break;
>
>    247                          /*
>    248                           * This HACK is needed to keep the expect=
ed
>    249                           * element list pointing to the right obj=
[elem].type
>    250                           * when the size is zero. ORD_LIST_ELEMEN=
TS
>    251                           * object is omitted by BIOS when the siz=
e is
>    252                           * zero.
>    253                           */
>    254                          if (int_value =3D=3D 0)
>    255                                  eloc++;
>    256                          break;
>    257                  case ORD_LIST_ELEMENTS:
>    258                          size =3D ordered_list_data->elements_size=
;
>
> We don't use size anywhere so this can be deleted.
>
>    259
>    260                          /*
>    261                           * Ordered list data is stored in hex and=
 comma separated format
>    262                           * Convert the data and split it to show =
each element
>    263                           */
>    264                          ret =3D hp_convert_hexstr_to_str(str_valu=
e, value_len, &tmpstr, &tmp_len);
>
> The value_len here is wrong.  We don't read value_len for ORD_LIST_ELEMEN=
TS
> or PREREQUISITES so this value_len comes from the PATH object.
The size
>
>    265                          if (ret)
>    266                                  goto exit_list;
>    267
>    268                          part_tmp =3D tmpstr;
>    269                          part =3D strsep(&part_tmp, COMMA_SEP);
>    270                          if (!part)
>    271                                  strscpy(ordered_list_data->elemen=
ts[0],
>    272                                          tmpstr,
>    273                                          sizeof(ordered_list_data-=
>elements[0]));
>    274
>    275                          for (elem =3D 1; elem < MAX_ELEMENTS_SIZE=
 && part; elem++) {
>
> Please don't re-use the "elem" iterator for this inner loop.
Done!
>
> regards,
> dan carpenter
>
>    276                                  strscpy(ordered_list_data->elemen=
ts[elem],
>    277                                          part,
>    278                                          sizeof(ordered_list_data-=
>elements[elem]));
>    279                                  part =3D strsep(&part_tmp, SEMICO=
LON_SEP);
>    280                          }
>    281
>    282                          kfree(str_value);
>    283                          str_value =3D NULL;
>    284                          break;
>    285                  default:
>    286                          pr_warn("Invalid element: %d found in Ord=
ered_List attribute or data may be malformed\n", elem);
>    287                          break;
>    288                  }
>    289                  kfree(tmpstr);
>    290                  tmpstr =3D NULL;
>    291                  kfree(str_value);
>    292                  str_value =3D NULL;
>    293          }
>    294
>    295  exit_list:
>    296          kfree(tmpstr);
>    297          kfree(str_value);
>    298          return 0;
>    299  }
>
>
